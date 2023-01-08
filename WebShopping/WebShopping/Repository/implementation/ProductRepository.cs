using Microsoft.EntityFrameworkCore;
using System.Linq;
using System.Linq.Expressions;
using WebShopping.Models;
using WebShopping.Repository.interfaces;

namespace WebShopping.Repository.implementation
{
    public class ProductRepository : Repository<Product, int>, IProductRepository
    {
        private readonly ApplicationDBContext context;

        public ProductRepository(ApplicationDBContext context) : 
            base(context)
        {
            this.context = context;
        }

        public override async Task<DataTableViewModel<TResult>> GetDataTable<TResult>(int start, int lenght, Expression<Func<Product, bool>> search, Expression<Func<Product, int>> OrderBy, Expression<Func<Product, TResult>> select)
        {
            var query = context.Products.Include(a=> a.SubCategory)
                .Include(a=> a.Carts)
                .OrderBy(OrderBy).Skip(start).Take(lenght).Where(search);

           
            var count = context.Products.Where(search).Count();

            return new DataTableViewModel<TResult>()
            {
                data = query.Select(select).ToList(),
                recordsFiltered = count,
                recordsTotal = count
            };
        }
    }
}
