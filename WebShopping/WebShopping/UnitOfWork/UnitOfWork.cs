using WebShopping.Models;
using WebShopping.Repository.implementation;
using WebShopping.Repository.interfaces;

namespace WebShopping.UnitOfWork
{
    public class UnitOfWork : IUnitOfWork
    {
        private readonly ApplicationDBContext context;

        public UnitOfWork(ApplicationDBContext context)
        {
            this.context = context;
            this.Products = new ProductRepository(context);
            this.Users = new UserRepository(context);
            this.Invoice = new InvoiceRepository(context);
        }
        public IProductRepository Products { get; }
        public IUserRepository Users { get; }

        public IInvoiceRepository Invoice { get; }

        public int Complete()
        {
           return  context.SaveChanges();
        }

        public void Dispose()
        {
            context.Dispose();
        }
    }
}
