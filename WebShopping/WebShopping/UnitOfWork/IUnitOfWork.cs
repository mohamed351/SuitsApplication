using WebShopping.Repository.implementation;
using WebShopping.Repository.interfaces;

namespace WebShopping.UnitOfWork
{
    public interface IUnitOfWork:IDisposable
    {

        public IProductRepository   Products { get;  }

        public IUserRepository Users { get;  }

        public IInvoiceRepository Invoice { get; }

        int Complete();
       

    }
}
