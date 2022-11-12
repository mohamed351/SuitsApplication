using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Linq;
using WebShopping.Areas.API.DTOS;
using WebShopping.Helpers;
using WebShopping.Models;

namespace WebShopping.Areas.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme)]
    public class InvoiceController : ControllerBase
    {
        private readonly ApplicationDBContext context;

        public InvoiceController(ApplicationDBContext context)
        {
            this.context = context;
        }
        [HttpGet]
        public IActionResult GetInvoices()
        {
            string userId = User.GetUserId();
          var query=  context.Invoices.Include(a=> a.InvoiceDetails).ThenInclude(a=> a.Product).Where(a => a.UserId == userId).Select(a =>
            new {
                Id = a.ID,
                a.InvoiceNumber,
                a.IsApproved,
                a.IsDeleted,
                a.TotalInvoice,
                Details = a.InvoiceDetails.Select(a =>
               new  {
                    a.Product.EnglishName,
                    a.Product.ArabicName,
                    a.Price,
                    a.Quantity,
                    a.Total
                })
                
            });
           
            return Ok(query);
        }
        [HttpPost]
        public async Task<IActionResult> CreateInvoice([FromBody]InvoiceCreateDTO createDTO)
        {
            int lastInvoiceNumber = context.Invoices.Select(a=> a.InvoiceNumber).ToList().DefaultIfEmpty(0).Max();

            string userId = User.GetUserId();
            Invoice invoice = new Invoice();
            invoice.CurrencyCode = createDTO.CurrencyCode;
            invoice.IsApproved = false;
            invoice.IsDeleted = false;
            invoice.UserId = User.GetUserId();
            invoice.TotalInvoice = createDTO.InvoiceData.Sum(a => a.Quantity * a.Price);
            invoice.InvoiceNumber = ++lastInvoiceNumber;
            foreach (var item in createDTO.InvoiceData)
            {
                invoice.InvoiceDetails.Add(new InvoiceDetails()
                {
                    Price = item.Price,
                    Quantity = item.Quantity,
                    Total = item.Price * item.Quantity,
                    ProductId = item.ProductId,
                    
                   
                    
                }); 
            }
            var listOfCart = context.Carts.Where(a => a.UserID == userId);
            context.RemoveRange(listOfCart);

            context.Invoices.Add(invoice);
           await context.SaveChangesAsync();
            
            return Ok(createDTO);
        }
    }
}
