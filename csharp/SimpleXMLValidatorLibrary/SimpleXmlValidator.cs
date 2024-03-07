namespace SimpleXMLValidatorLibrary
{
    public class SimpleXmlValidator
    {
        private static bool tryCompileEndAngleBracket(string xml, int index)
        {
            for (int i = index; i < xml.Length;i++)
            {
                if (xml[i] == '<')
                {
                    if(i+1 < xml.Length && xml[i+1]=='/')
                    {
                        return true;
                    }
                    else
                    {
                        return false;
                    }
                }
                else if (xml[i] == '>')
                {
                    return false;
                }
            }

            return false;
        }
        private static bool compileXml(string xml, int index, Stack<string>skb)
        {
            if(index >= xml.Length)
            {
                if(skb.Count > 0)
                {
                    return false;
                }
                return true;
            }

            if(tryCompileEndAngleBracket(xml, index))
            {
                int i_next_st = xml.IndexOf("</", index);
                if (-1 == i_next_st) return false;
                int i_next_end = xml.IndexOf('>', i_next_st);
                if (-1 == i_next_end) return false;

                string content = xml.Substring(i_next_st+2, i_next_end - i_next_st-2);
                if(!content.Equals(skb.Pop())) {
                    return false;
                }
                return compileXml(xml, i_next_end + 1, skb);
            }
            else
            {
                int i_st = xml.IndexOf('<', index);
                if(-1 == i_st) return false;
                int i_end = xml.IndexOf('>', i_st);
                if (-1 == i_end) return false;

                string content = xml.Substring(i_st+1, i_end - i_st-1);
                skb.Push(content);
                return compileXml(xml, i_end+1, skb);
            }
        }
        public static bool DetermineXml(string xml)
        {
            if (xml.IndexOf('<') == -1) {
                return false ;
            } 

            Stack<string> skb = new Stack<string>();
            return compileXml(xml, 0, skb);
        }
    }
}