using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using ProjectZ.Models.Database;

namespace ProjectZ.Models
{
    public class TopicWithComments
    {
        public Topic Topic { get; set; }
        public IEnumerable<TopicComment> Comment { get; set; }
    }
}