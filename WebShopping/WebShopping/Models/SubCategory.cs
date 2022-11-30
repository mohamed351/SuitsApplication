using System.ComponentModel.DataAnnotations.Schema;

namespace WebShopping.Models
{
    public class SubCategory
    {
        public SubCategory()
        {
            this.Products = new HashSet<Product>();
        }
        public int ID { get; set; }

        public string ArabicName { get; set; } = String.Empty;

        public string EnglishName { get; set; } = String.Empty;

        [ForeignKey(nameof(Category))]
        public int CategoryID { get; set; }
        public Category? Category { get; set; }

        public ICollection<Product> Products { get; set; }

        public string ImageUrl { get; set; }



    }

}
