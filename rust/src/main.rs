use std::{env};

fn main() {
    let args = env::args().collect::<Vec<_>>();
    let default_input = "".to_string();
    let input = args.get(1).unwrap_or(&default_input);

    let result = if determine_xml(input) {
        "Valid"
    } else {
        "Invalid"
    };
    println!("{}", result);
}

fn try_compile_endanglebracket(s: &String, index: usize) -> bool {
    for i in index..s.len() {
        match s.chars().nth(i) {
            Some('<') => {
                if i + 1 < s.len() && s.chars().nth(i + 1) == Some('/') {
                    return true;
                }
                else {
                    return false;
                }
            }
            Some('>') => return false,
            _ => continue,
        }
    }

    false
}

fn compile_xml(s: &String, index: usize, stack: &mut Vec<String>) -> bool {
    if index == s.len() {
        return stack.is_empty();
    }

    match try_compile_endanglebracket(s, index) {
        true => {
            let i_next_st = s[index..].find("</").map(|idx| idx + index).unwrap_or(s.len());
            if i_next_st == s.len() {
                return false;
            }
            let i_next_end = s[i_next_st..].find(">").map(|idx| idx + i_next_st).unwrap_or(s.len());
            if i_next_end == s.len() {
                return false;
            }
            if i_next_end - i_next_st < 3 {
                // content is zero length
                return false;
            }
            let content = s[i_next_st+2..i_next_end].to_string();
            if stack.is_empty() {
                return false;
            }
            if stack.pop() != Some(content) {
                return false;
            }
            return compile_xml(s, i_next_end + 1, stack);
        }
        false => {
            let i_st = s[index..].find("<").map(|idx| idx + index).unwrap_or(s.len());
            if i_st == s.len() {
                return false;
            }
            let i_end = s[i_st..].find(">").map(|idx| idx + i_st).unwrap_or(s.len());
            if i_end == s.len() {
                return false;
            }
            if i_end - i_st < 2 {
                // content is zero length
                return false;
            }
            let content = s[i_st+1..i_end].to_string();
            // println!("push content: {}", content);
            stack.push(content);

            return compile_xml(s, i_end + 1, stack);
        }
    }
}


fn determine_xml(input: &String) -> bool {
    if input.contains('<') {
        let mut stack = Vec::new();    
        return compile_xml(input, 0, &mut stack);
    }

    return false;
}

#[cfg(test)]
mod tests {
    use test_case::test_case;

    use crate::determine_xml;

    // You can use here to test, feel free to modify/add the test cases here.
    // You can run tests with `cargo test`.
    // You can also use other ways to test if you want.

    #[test_case("<Design><Code>hello world</Code></Design>", true ; "normal case")]
    #[test_case("<Design><Code>hello world</Code></Design><People>", false ; "no closing tag")]
    #[test_case("<People><Design><Code>hello world</People></Code></Design>", false ; "non-corresponding tags")]
    // there is no closing tag for "People age=”1”" and no opening tag for "/People"
    #[test_case("<People age=”1”>hello world</People>", false ; "attribute is not supported")]
    fn check_determine_xml(input: &'static str, expected: bool) {
        let input = input.to_string();
        assert_eq!(expected, determine_xml(&input));
    }
}
