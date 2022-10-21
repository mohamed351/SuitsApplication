using Microsoft.Build.Framework;

namespace WebShopping.Areas.API.DTOS
{
    public class LoginDTO
    {
        [Required]
        public string PhoneNumber { get; set; }
        [Required]
        public string Password { get; set; }

    }
}
