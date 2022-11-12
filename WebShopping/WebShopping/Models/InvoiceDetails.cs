using System.ComponentModel.DataAnnotations.Schema;

namespace WebShopping.Models
{
    public class InvoiceDetails
    {
        public int ID { get; set; }


        public int InvoiceID { get; set; }
        [ForeignKey(nameof(InvoiceID))]
        public Invoice  Invoice { get; set; }

        public int ProductId { get; set; }
        [ForeignKey(nameof(ProductId))]
        public Product Product { get; set; }

        public decimal Price { get; set; }


        public decimal Quantity { get; set; }


        public decimal Total { get; set; }

        


    }
}
