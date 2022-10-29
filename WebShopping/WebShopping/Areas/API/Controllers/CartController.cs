using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Hosting;
using WebShopping.Areas.API.DTOS;
using WebShopping.Helpers;
using WebShopping.Models;

namespace WebShopping.Areas.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme)]
    public class CartController : ControllerBase
    {
        private readonly ApplicationDBContext context;
        private readonly IHttpContextAccessor httpContextAccessor;

        public CartController(ApplicationDBContext context , IHttpContextAccessor httpContextAccessor)
        {
            this.context = context;
            this.httpContextAccessor = httpContextAccessor;
        }
        [HttpGet]
        public IActionResult GetCart()
        {
            var currentUser = User.GetUserId();
            string host = httpContextAccessor.HttpContext.Request.Host.Value;
            string schema = httpContextAccessor.HttpContext.Request.Scheme;
            var cartQuery = context.Carts.Include(a => a.Product).Where(a => a.UserID == currentUser).Select(a => new
            {
                a.Product.PurchasingPriceForPublic,
                a.Product.PurchasingPriceForSales,
                a.ProductID,
                a.Quantity,
                TotalSales  = a.Quantity *  a.Product.PurchasingPriceForSales,
                 TotalPublich = a.Quantity * a.Product.PurchasingPriceForPublic,
                 ImageUrl =  schema + "://" + host + "/api/Image/" + a.Product.ImageUrl
            });
            return Ok(cartQuery);
           
        }
        [HttpGet("/{id}/Product")]
        public IActionResult GetProductInCart(int id)
        {
            var currentUser = User.GetUserId();
           var currentCart = context.Carts.FirstOrDefault(a => a.UserID == currentUser && a.ProductID == id);
            return Ok(currentCart);
        }
        [HttpPost]
        public IActionResult AddingCart([FromBody]CartDTO cart)
        {
            var currentUser = User.GetUserId();
           var currentCart  = context.Carts.FirstOrDefault(a => a.ProductID == cart.ProductID && a.UserID == currentUser);
            if(currentCart == null)
            {
                context.Carts.Add(new Cart() { ProductID = cart.ProductID, UserID = currentUser, Quantity = cart.Quantity });
               
            }
            else
            {
                currentCart.Quantity = currentCart.Quantity + cart.Quantity;
            }
            context.SaveChanges();


            return Ok(currentUser);
        }


    }
}
