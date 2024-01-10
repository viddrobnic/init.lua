; extends
(var_declaration
  (var_spec 
    name: (identifier) @spell))

(const_declaration 
  (const_spec 
    name: (identifier) @spell))

(short_var_declaration 
  left: (expression_list 
          (identifier) @spell))

(function_declaration 
  name: (identifier) @spell)

(package_clause
  (package_identifier) @spell)
