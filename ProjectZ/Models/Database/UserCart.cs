//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace ProjectZ.Models.Database
{
    using System;
    using System.Collections.Generic;
    
    public partial class UserCart
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public UserCart()
        {
            this.UserCartProducts = new HashSet<UserCartProduct>();
        }
    
        public int Id { get; set; }
        public int UserId { get; set; }
        public System.DateTime CreationDate { get; set; }
        public Nullable<bool> Result { get; set; }
    
        public virtual User User { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<UserCartProduct> UserCartProducts { get; set; }
    }
}
