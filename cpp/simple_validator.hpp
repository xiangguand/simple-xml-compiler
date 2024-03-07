#include <stack>
#include <string>

using namespace std;

//*****************************************************************************
//
//! Function trying to compile end angle bracket (</) pattern
//!
//! \param[in]   s input string
//! \param[in]   index  current index of parsing string
//! \param[out]  i_out  index of '<', index+1 must be '/'
//! \return      Find end angle bracket (</) pattern or not (true: find it)
//
//*****************************************************************************
bool tryCompileEndAngleBracket(string s, int index, int &i_out) {
  int fg = 0;
  for (int i = index; i < s.npos; i++) {
    if (s[i] == '<') {
      if (i + 1 < s.npos && s[i + 1] == '/') {
        i_out = i;
        return true;
      } else {
        return false;
      }
    } else if (s[i] == '>') {
      return false;
    }
  }

  return false;
}

//*****************************************************************************
//
//! Function compiling XML
//!
//! \param[in]   s input string
//! \param[in]   index  current index of parsing string
//! \param[in]   skb  Store bracket contents
//! \return      True: valid XML string, False: Invalid XML string
//
//*****************************************************************************
bool compileXml(string s, int index, stack<string>skb) {
  if (index >= s.length()) {
    if(skb.size() > 0) {
      return false;
    }
    return true;
  }
  
  int i_next_st;
  if (!tryCompileEndAngleBracket(s, index, i_next_st)) {
    int i_st = s.find("<", index);
    if (i_st == s.npos)
      return false;
    int i_end = s.find(">", i_st + 1);
    if (i_end == s.npos)
      return false;

    string content = s.substr(i_st + 1, i_end - i_st - 1);
    skb.push(content);
    return compileXml(s, i_end + 1, skb);
  } else {
    i_next_st = s.find("</", index);
    int i_next_end = s.find(">", i_next_st);
    if (i_next_end == s.npos)
      return false;

    string content = s.substr(i_next_st + 2, i_next_end - i_next_st - 2);
    if(content != skb.top()) {
      return false;
    }
    skb.pop();
    return compileXml(s, i_next_end + 1, skb);
  }

  return false;
}

bool DetermineXml(const std::string &input) {
  if(0 == input.size()) return false;
  if(input.find("<") == input.npos) return false;
  stack<string>skb;
  return compileXml(input, 0, skb);
}
