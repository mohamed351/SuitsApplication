using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using WebShopping.Models;
using WebShopping.ViewModel;

namespace WebShopping.Controllers
{
    
    public class AccountController : Controller
    {
        private readonly SignInManager<ApplicationUser> signInManager;
        private readonly UserManager<ApplicationUser> userManager;

        public AccountController(SignInManager<ApplicationUser> signInManager , UserManager<ApplicationUser> userManager)
        {
            this.signInManager = signInManager;
            this.userManager = userManager;
        }
        public IActionResult Login()
        {
            return View();
        }
        [HttpPost]
        public async Task<IActionResult> Login(LoginViewModel loginViewModel)
        {
            if (ModelState.IsValid)
            {
                var user = userManager.Users.FirstOrDefault(a => a.UserName == loginViewModel.UserName);
                if(user == null)
                {
                    ModelState.TryAddModelError("info", "userName or password is wrong");
                    return View();
                }

               var result = await signInManager.PasswordSignInAsync(user, loginViewModel.Password, loginViewModel.RememberMe, false);
                if (result.Succeeded)
                {
                    return RedirectToAction("Index", "Home");
                }
                else
                {
                    ModelState.TryAddModelError("info", "userName or password is wrong");
                    
                }

            }
           
            return View();
        }

        
    }
}
