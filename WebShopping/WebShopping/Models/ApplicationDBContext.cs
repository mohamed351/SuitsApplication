﻿using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;

namespace WebShopping.Models
{
    public class ApplicationDBContext:IdentityDbContext<ApplicationUser>
    {
        public ApplicationDBContext(DbContextOptions<ApplicationDBContext> options)
            :base(options)
        {

        }

        public DbSet<Product> Products { get; set; }


        public DbSet<Category> Categories { get; set; }


        public DbSet<SubCategory> SubCategories { get; set; }

        public DbSet<ApplicationUser> ApplicationUsers { get; set; }
    }
}
