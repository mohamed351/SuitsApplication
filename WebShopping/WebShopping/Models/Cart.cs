using MessagePack;
using System.ComponentModel.DataAnnotations.Schema;

namespace WebShopping.Models
{
    public class Cart
    {
        [ForeignKey(nameof(ApplicationUser))]
        public string UserID { get; set; }

        [ForeignKey(nameof(Product))]
        public int ProductID { get; set; }

        public int Quantity { get; set; }


        public Product Product { get; set; }


        public ApplicationUser ApplicationUser { get; set; }
    }
}
