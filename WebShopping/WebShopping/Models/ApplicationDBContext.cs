using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
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


        public DbSet<Cart> Carts { get; set; }


        public DbSet<Invoice> Invoices { get; set; }


        public DbSet<InvoiceDetails> InvoiceDetails { get; set; }

        public DbSet<Brand> Brands { get; set; }

        protected override void OnModelCreating(ModelBuilder builder)
        {
            builder.Entity<Cart>()
                .HasKey(a => new { a.ProductID, a.UserID });
            base.OnModelCreating(builder);
        }
    }
}
