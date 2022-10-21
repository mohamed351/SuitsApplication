using Microsoft.AspNetCore.Identity;
using Microsoft.Build.Framework;

namespace WebShopping.Models
{
    public class ApplicationUser:IdentityUser
    {
    
        public string PharmacyName { get; set; } = String.Empty;
    
        public string DoctorName { get; set; } = String.Empty;


        public string Address { get; set; } = String.Empty;



        public bool IsApprove { get; set; }





    }
}
