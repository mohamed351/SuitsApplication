using Microsoft.AspNetCore.Mvc.RazorPages;
using System.ComponentModel.DataAnnotations.Schema;
using WebShopping.Models;

namespace WebShopping.Areas.API.DTOS
{
    public class InvoiceCreateDTO
    {
        public InvoiceCreateDTO()
        {
            InvoiceData = new List<InvoiceDetailsCreateDTO>();
        }
   

        public string CurrencyCode { get; set; }



        public List<InvoiceDetailsCreateDTO> InvoiceData { get; set; }

    }
    public class InvoiceDetailsCreateDTO
    {
        public int ID { get; set; }


        public int ProductId { get; set; }
      

        public decimal Price { get; set; }


        public decimal Quantity { get; set; }


        public decimal Total { get; set; }
    }
}
