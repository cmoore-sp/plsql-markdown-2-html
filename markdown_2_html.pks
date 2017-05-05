create or replace package markdown_2_html
as

function md_2_html (
	P_TEXT			in clob
	) return clob;
	
end markdown_2_html;
