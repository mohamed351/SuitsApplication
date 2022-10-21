using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using WebShopping.Models;
using WebShopping.UnitOfWork;

namespace WebShopping.Controllers
{
    [Authorize]
    public class UserController : Controller
    {
        private readonly IUnitOfWork unitOfWork;
        private readonly ApplicationDBContext context;

        public UserController(IUnitOfWork unitOfWork, ApplicationDBContext context)
        {
            this.unitOfWork = unitOfWork;
            this.context = context;
        }
        public IActionResult Index()
        {
            return View();
        }
        [HttpGet]
        public async Task<IActionResult> GetUser(int start = 0, int length = 10)
        {
            var search = Request.Query["search[value]"].ToString();
         var query = await unitOfWork.Users.GetDataTable(start, length, a => a.PhoneNumber.Contains(search), a => a.Id);
           
            return Json(query);
        }
        [HttpPost]
        public async Task<IActionResult> Approve([FromBody] string userId)
        {
           var currentUser = context.ApplicationUsers.FirstOrDefault(a => a.Id == userId);
            currentUser.IsApprove = !currentUser.IsApprove;
           await context.SaveChangesAsync();
            return Ok(currentUser.IsApprove);
        }

    }
}
