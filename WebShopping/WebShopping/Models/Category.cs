namespace WebShopping.Models
{
    public class Category
    {

        public Category()
        {
            this.SubCategories = new HashSet<SubCategory>();
        }
        public int ID { get; set; }

        public string ArabicName { get; set; } = String.Empty;

        public string EnglishName { get; set; } = String.Empty;


        public ICollection<SubCategory> SubCategories { get; set; }  

    }

}
