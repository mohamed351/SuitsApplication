using WebShopping.Repository.interfaces;

namespace WebShopping.UnitOfWork
{
    public interface IUnitOfWork:IDisposable
    {

        public IProductRepository   Products { get;  }

        public IUserRepository Users { get;  }

        int Complete();
       

    }
}
