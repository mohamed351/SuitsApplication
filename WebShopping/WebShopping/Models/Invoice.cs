namespace WebShopping.Models
{
    public class Invoice
    {
        public Invoice()
        {
            InvoiceDetails = new HashSet<InvoiceDetails>();
        }
        public int ID { get; set; }

        public string UserId { get; set; }

        public ApplicationUser User { get; set; }

        public int InvoiceNumber { get; set; }


        public string CurrencyCode { get; set; }

        public decimal TotalInvoice { get; set; }

        public bool IsApproved { get; set; }
        public bool IsDeleted { get; set; }

        public ICollection<InvoiceDetails> InvoiceDetails { get; set; }



    }
}
