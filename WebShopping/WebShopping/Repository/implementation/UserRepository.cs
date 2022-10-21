using WebShopping.Models;
using WebShopping.Repository.interfaces;

namespace WebShopping.Repository.implementation
{
    public class UserRepository : Repository<ApplicationUser, string>, IUserRepository
    {
        public UserRepository(ApplicationDBContext context) : base(context)
        {


        }


    }
}
