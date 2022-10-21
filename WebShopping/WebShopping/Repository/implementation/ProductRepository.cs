using WebShopping.Models;
using WebShopping.Repository.interfaces;

namespace WebShopping.Repository.implementation
{
    public class ProductRepository : Repository<Product, int>, IProductRepository
    {
        public ProductRepository(ApplicationDBContext context) : 
            base(context)
        {
        }
    }
}
