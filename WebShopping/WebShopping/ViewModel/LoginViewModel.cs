using Microsoft.Build.Framework;
using System.ComponentModel.DataAnnotations;
using RequiredAttribute = System.ComponentModel.DataAnnotations.RequiredAttribute;

namespace WebShopping.ViewModel
{
    public class LoginViewModel
    {

        [Required]
        public string UserName { get; set; } = String.Empty;
        [Required]
        public string Password { get; set; } = String.Empty;

 
        public bool  RememberMe { get; set; }
    }
}
