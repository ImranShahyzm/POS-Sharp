﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace POS.Helper
{
    public class ComoboClass
    {
        
            public string Text { get; set; }
            public object Value { get; set; }

            public override string ToString()
            {
                return Text;
            }
       
    }
    public static class MyModel
    {
        public static string Key { get; set; }
    }
}


