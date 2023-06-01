using System.ComponentModel.DataAnnotations.Schema;
using System.Diagnostics.CodeAnalysis;

namespace WebShopping.Models
{
    public class Product
    {
        public Product()
        {
            this.Carts = new HashSet<Cart>();
        }
        public int ID { get; set; }

        public string EnglishName { get; set; } = String.Empty;

        public string ArabicName { get; set; } = String.Empty;


        public decimal SellingPrice { get; set; }

        public decimal PurchasingPriceForPublic { get; set; }

        public decimal PurchasingPriceForSales { get; set; }


        public int Quantity { get; set; }


        public string? ImageUrl { get; set; } = String.Empty;

        public string DescriptionArabic { get; set; } = String.Empty;

        public string DescriptionEnglish { get; set; } = String.Empty;

        public bool IsDeleted { get; set; }

        [ForeignKey(nameof(SubCategory))]
        public int SubCategoryID { get; set; }

        public SubCategory? SubCategory { get; set; }

        [AllowNull]
        public int? BrandID { get; set; }


        public Brand? Brand { get; set; }

        public string BarCode { get; set; }



        public ICollection<Cart> Carts { get; set; }











    }

}
