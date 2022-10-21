using Microsoft.AspNetCore.Identity;
using WebShopping.Models;

namespace WebShopping.Seeder
{
    public  static class Seeding
    {
        public static async Task SeedingData(IApplicationBuilder builder)
        {

            using(var serviceScoped = builder.ApplicationServices.CreateScope())
            {
                var context = serviceScoped.ServiceProvider.GetService<ApplicationDBContext>();
                var roleManager = serviceScoped.ServiceProvider.GetService<RoleManager<IdentityRole>>();
                var userManager = serviceScoped.ServiceProvider.GetService<UserManager<ApplicationUser>>();
                var config = serviceScoped.ServiceProvider.GetService<IConfiguration>();
                 await   SeedRole(roleManager);
                await SeedUser(userManager, config);


            }
        }

        public static async Task SeedUser(UserManager<ApplicationUser> userManager , IConfiguration configuration)
        {
            if (!userManager.Users.Any())
            {
                var user = new ApplicationUser()
                {
                    UserName = configuration["DefaultUsers:userName"],
                    Email = configuration["DefaultUsers:email"],
                    PhoneNumber = configuration["DefaultUsers:phone"],

                };
               var currentUser = await userManager.CreateAsync(user, configuration["DefaultUsers:password"]);
                if (currentUser.Succeeded)
                {
                    await userManager.AddToRoleAsync(user, "Admin");
                }
               

            }

        }
        public static async Task SeedRole(RoleManager<IdentityRole> roleManager)
        {
           if(!roleManager.Roles.Any())
            {
               await roleManager.CreateAsync(new IdentityRole("Admin"));
                await roleManager.CreateAsync(new IdentityRole("Sales"));
                await roleManager.CreateAsync(new IdentityRole("pharmacy"));
            }


        }
    }
}
