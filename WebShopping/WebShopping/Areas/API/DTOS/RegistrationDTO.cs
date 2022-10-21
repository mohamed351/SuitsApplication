using Microsoft.Build.Framework;

namespace WebShopping.Areas.API.DTOS
{
    public class RegistrationDTO
    {

        [Required]
        public string PharamceyName { get; set; } = string.Empty;
  
        [Required]
        public string DoctorName { get; set; } = string.Empty;
        [Required]
        public string PhoneNumber { get; set; } = string.Empty;

        public string Address { get; set; }

        [Required]
        public string Email { get; set; } = string.Empty;
        [Required]
        public string Password { get; set; } = string.Empty;


    }
}
