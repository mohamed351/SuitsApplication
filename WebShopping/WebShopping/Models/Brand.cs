namespace WebShopping.Models
{
    public class Brand
    {

        public Brand()
        {
            this.Products = new HashSet<Product>();
        }
        public int ID { get; set; }

        public string BrandArabic { get; set; }

        public string BrandEnglish { get; set; }


        public string? ImageUrl { get; set; }


        public bool IsDeleted { get; set; }

        public ICollection<Product> Products { get; set; }


    }
}
