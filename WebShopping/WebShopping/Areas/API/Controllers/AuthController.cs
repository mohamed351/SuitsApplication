using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Security.Cryptography;
using System.Text;
using WebShopping.Areas.API.DTOS;
using WebShopping.Models;

namespace WebShopping.Areas.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AuthController : ControllerBase
    {
        private readonly UserManager<ApplicationUser> userManager;

        public AuthController(UserManager<ApplicationUser> userManager, IConfiguration configuration)
        {
            this.userManager = userManager;
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }
        [HttpPost("login")]
        public async Task<IActionResult> Login([FromBody]LoginDTO dTO)
        {
           var currentUser = userManager.Users.FirstOrDefault(a => a.PhoneNumber == dTO.PhoneNumber);
           
            if(currentUser == null)
            {
                return Unauthorized(new {message ="username of password is not correct" });
            }
            if (!currentUser.IsApprove)
            {
                return Unauthorized(new { message = "you need approve" });
            }
            //register Claims
            if(!(await userManager.CheckPasswordAsync(currentUser, dTO.Password)))
            {
                return Unauthorized(new { message = "username of password is not correct" });

            }
        
            var claims = new List<Claim>()
            {
                new Claim(ClaimTypes.Name,currentUser.UserName),
                new Claim(ClaimTypes.NameIdentifier, currentUser.Id),
                new Claim(ClaimTypes.Email, currentUser.Email),
                new Claim(ClaimTypes.MobilePhone,currentUser.PhoneNumber)
            };
            var t = Encoding.Unicode.GetBytes(Configuration["AppSettings:token"]);
 
             var key = new SymmetricSecurityKey(t); 
            var signer = new SigningCredentials(key, SecurityAlgorithms.HmacSha512Signature);
            var tokenDescrptor = new SecurityTokenDescriptor()
            {
                Subject = new ClaimsIdentity(claims),
                Expires = DateTime.Now.AddDays(1),
                SigningCredentials = signer
            };

            var tokenHandler = new JwtSecurityTokenHandler();
            var token = tokenHandler.CreateToken(tokenDescrptor);
            return Ok(new { token = tokenHandler.WriteToken(token) , userId = currentUser.Id , expireDate =  tokenDescrptor.Expires.Value });

        }
        [HttpPost("register")]
        public  async Task<IActionResult> Registration([FromBody] RegistrationDTO registrationDTO)
        {

            var currentUser = new ApplicationUser()
            {
                Email = registrationDTO.Email,
                PhoneNumber = registrationDTO.PhoneNumber,
                Address = registrationDTO.Address,
                PharmacyName = registrationDTO.PharamceyName,
                DoctorName = registrationDTO.DoctorName,
                IsApprove = false,
                UserName = registrationDTO.PhoneNumber
            };
           var result  =   await userManager.CreateAsync(currentUser,registrationDTO.Password);
            if (result.Succeeded)
            {
                return Ok(new { message = "you need approve" });
            }
            else
            {
                return BadRequest(new { error = result.Errors });
            }


        }
    }
}
