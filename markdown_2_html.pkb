create or replace package body markdown_2_html
as
			cr					constant varchar2(1) := chr(10);
			crlf				constant varchar2(2) := chr(13) || chr(10) ;
			nl					constant varchar2(4) := '/n';
-- calling code is below
/*
declare
	l_clob 			clob;
begin
for c in (
	select
		markdown_pk,
		markdown_clob
	from mrk_clob
	where markdown_pk = 1
	) loop
	l_clob := markdown_2_html.md_2_html(c.markdown_clob);
end loop; -- clob loop
dbms_output.put_line(l_clob);
end;
*/
function h (
	P_TEXT		in varchar2
	) return varchar2
-------------------------------------------------------------------------------
-- FUNCTION				H
-- Prepares HTML headers from H1 to H6. 
-- 
-- Written				25APR2017
--								cmoore
--
-- Modifications:
--
--
--
-------------------------------------------------------------------------------
as
	l_count			number;
	l_return		varchar2(2000);
begin
l_count := regexp_count(P_TEXT,'#');
l_return := trim(regexp_replace(P_TEXT,'#',''));
if l_count between 1 and 6 then
	l_return := '<h' || trim(to_char(l_count)) || '>' ||
		l_return ||
		'</h' || trim(to_char(l_count)) || '>';
else
	l_return := '<h1>' || l_return || '/h1>';
end if;
return l_return;
end h;

function crlf_2_br (
	P_TEXT					in varchar2
	) return 				varchar2
-------------------------------------------------------------------------------
-- FUNCTION				crlf_2_br
-- converts pairs of end-of-line to <br /> within text
-- function is overloaded to accommodate varchar2 and clob.
-- Looks for both cr and crlf
--
-- Written				24APR2017
--								cmoore
--
-- Modifications:
--
--
--
-------------------------------------------------------------------------------	
as
	l_position			number;
	l_return 				varchar2(4000);
begin
	if instr(P_TEXT, cr || cr) > 0 then
		l_return := replace(P_TEXT, cr || cr, '<br />');
	end if;
	if instr(P_TEXT, crlf || crlf) > 0 then
		l_return := replace(P_TEXT, crlf || crlf, '<br />');
	end if;
	return l_return;
end crlf_2_br;

function crlf_2_br (
	P_TEXT					in clob
	) return 				clob
-------------------------------------------------------------------------------
-- FUNCTION				crlf_2_br
-- converts pairs of end-of-line to <br /> within text
-- function is overloaded to accommodate varchar2 and clob.
-- Looks for both cr and crlf
--
-- Written				24APR2017
--								cmoore
--
-- Modifications:
--
--
--
-------------------------------------------------------------------------------	
as
	l_position			number;
	l_return 				clob;
begin
if instr(P_TEXT, cr || cr) > 0 then
	l_return := replace(P_TEXT, cr || cr, '<br />');
end if;
if instr(P_TEXT, crlf || crlf) > 0 then
	l_return := replace(P_TEXT, crlf || crlf, '<br />');
end if;
return l_return;
end crlf_2_br;

function crlf_2_nl (
	P_TEXT					in varchar2
	) return 				varchar2
-------------------------------------------------------------------------------
-- FUNCTION				crlf_2_nl
-- converts pairs of end-of-line to newline (global constant) within text
-- function is overloaded to accommodate varchar2 and clob.
-- Looks for both cr and crlf
--
-- Written				24APR2017
--								cmoore
--
-- Modifications:
--
--
--
-------------------------------------------------------------------------------	
as
	l_position			number;
	l_return 				varchar2(4000);
begin
	if instr(P_TEXT, cr) > 0 then
		l_return := replace(P_TEXT, cr, nl);
	end if;
	if instr(P_TEXT, crlf) > 0 then
		l_return := replace(P_TEXT, crlf, nl);
	end if;
	return l_return;
end crlf_2_nl;

function crlf_2_nl (
	P_TEXT					in clob
	) return 				clob
-------------------------------------------------------------------------------
-- FUNCTION				crlf_2_nl
-- converts pair end-of-line to newline (global constant) within text
-- function is overloaded to accommodate varchar2 and clob.
-- Looks for both cr and crlf
--
-- Written				24APR2017
--								cmoore
--
-- Modifications:
--
--
--
-------------------------------------------------------------------------------	
as
	l_position			number;
	l_return 				clob;
begin
if instr(P_TEXT, cr) > 0 then
	l_return := replace(P_TEXT, cr, nl);
end if;
if instr(P_TEXT, crlf) > 0 then
	l_return := replace(P_TEXT, crlf, nl);
end if;
return l_return;
end crlf_2_nl;

function nl_2_crlf (
	P_TEXT					in clob
	) return 				clob
-------------------------------------------------------------------------------
-- FUNCTION				nl_2_crlf
-- converts end-of-line to newline (global constant) within text
-- function is overloaded to accommodate varchar2 and clob.
--
-- Written				24APR2017
--								cmoore
--
-- Modifications:
--
--
--
-------------------------------------------------------------------------------	
as
	l_position			number;
	l_return 				clob;
begin
if instr(P_TEXT, nl) > 0 then
	l_return := replace(P_TEXT, nl, crlf);
end if;
return l_return;
end nl_2_crlf;

function nl_2_crlf (
	P_TEXT					in varchar2
	) return 				varchar2
-------------------------------------------------------------------------------
-- FUNCTION				nl_2_crlf
-- converts end-of-line to newline (global constant) within text
-- function is overloaded to accommodate varchar2 and clob.
--
-- Written				24APR2017
--								cmoore
--
-- Modifications:
--
--
--
-------------------------------------------------------------------------------		
as
	l_position			number;
	l_return 				varchar2(4000);
begin
if instr(P_TEXT, nl) > 0 then
	l_return := replace(P_TEXT, nl, crlf);
end if;
return l_return;
end nl_2_crlf;

function nl_2_br (
	P_TEXT					in clob
	) return 				clob
-------------------------------------------------------------------------------
-- FUNCTION				nl_2_crlf
-- converts newline (global constant) to <br /> within text
-- function is overloaded to accommodate varchar2 and clob.
--
-- Written				24APR2017
--								cmoore
--
-- Modifications:
--
--
--
-------------------------------------------------------------------------------		
as
	l_position			number;
	l_return 				clob;
begin
if instr(P_TEXT, nl) > 0 then
	l_return := replace(P_TEXT, nl, '<br/>');
end if;
return l_return;
end nl_2_br;

function nl_2_br (
	P_TEXT					in varchar2
	) return 				varchar2
-------------------------------------------------------------------------------
-- FUNCTION				nl_2_crlf
-- converts newline (global constant) to <br /> within text
-- function is overloaded to accommodate varchar2 and clob.
--
-- Written				24APR2017
--								cmoore
--
-- Modifications:
--
--
--
-------------------------------------------------------------------------------		
as
	l_position			number;
	l_return 				varchar2(4000);
begin
if instr(P_TEXT, nl) > 0 then
	l_return := replace(P_TEXT, nl, '<br/>');
end if;
return l_return;
end nl_2_br;

function column_align (
	P_COLUMN			in  wwv_flow_global.vc_arr2,
	P_INDEX				in pls_integer,
	P_ROW_OUT			in varchar2,
	P_HEADER			in varchar
	) return varchar2
as
-------------------------------------------------------------------------------
-- FUNCTION				column_align
-- uses the array P_COLUMN to determin the text alignment for each column
-- 
-- P_HEADER is either 'h' for header or 'd' for detail
--
-- Written				24APR2017
--								cmoore
--
-- Modifications:
--
--
--
-------------------------------------------------------------------------------
	l_row_out			varchar2(4000);
begin
l_row_out := P_ROW_OUT;
case
	when P_COLUMN(P_INDEX) = 'right' then
		l_row_out := l_row_out || '<t' || P_HEADER || ' align="right">';
	when P_COLUMN(P_INDEX) = 'center' then
		l_row_out := l_row_out || '<t' || P_HEADER || ' align="center">';
	else
		l_row_out := l_row_out || '<t' || P_HEADER || ' align="left">';
end case;
return l_row_out;
exception when no_data_found then
return l_row_out || '<t' || P_HEADER || ' align="left">';
end column_align;

function md_2_html (
	P_TEXT			in clob
	) return clob
-------------------------------------------------------------------------------
-- FUNCTION				md_2_html
--	returns				clob
-- converts markdown to HTML in a clob that is less than 32K
-- notes:
--		As of April 2017, the UL/OL process does not accommodate nesting
--		And tables do require a leading and trailing pipe '|'
--
-- Written				24APR2017
--								cmoore
--
-- Modifications:
--
--
--
-------------------------------------------------------------------------------		
as
  l_text 						varchar2(32767);
  l_row_in					wwv_flow_global.vc_arr2;
	l_column					wwv_flow_global.vc_arr2;
	l_pipe_count			pls_integer;
	l_column_count		pls_integer;
	l_left_pos				pls_integer;
	l_right_pos				pls_integer;
	l_left_side				varchar2(5);
	l_right_side			varchar2(5);
	l_row_out					varchar2(4000);
	l_text_out				varchar2(32767);
	l_in_ol						boolean	:= false;
	l_in_ul						boolean	:= false;
	l_in_table				boolean	:= false;
	l_in_blockq				boolean := false;
	l_in_code					boolean	:= false;
	l_skip_line				boolean	:= false;
	l_newline					varchar2(4);
	l_ol_row					number 	:= 0;
	l_ul_row					number 	:= 0;
	l_table_row				number	:= 0;
	l_blockq_row			number	:= 0;
	l_code_row				number	:= 0;
begin
if dbms_lob.getlength(P_TEXT) < 32000 then
	--l_text := crlf_2_nl(P_TEXT);
	l_text := P_TEXT;
	case 
		when instr(l_text, crlf) > 0 then
			l_row_in := apex_util.string_to_table(l_text, crlf);
			l_newline	:= crlf;
		when instr(l_text, cr) > 0 then
			l_row_in := apex_util.string_to_table(l_text, cr);
			l_newline	:= cr;
		when instr(l_text, nl) > 0 then
			l_row_in := apex_util.string_to_table(l_text, nl);
			l_newline	:= nl;
		else
			null;
	end case;
		
  for i in 1 .. l_row_in.count loop
	
		-- line type
		case
			-- HEADER
			when substr(l_row_in(i),1,1) = '#' then
				l_row_out := h(l_row_in(i));

				-- Note on lists, at present, these are NOT nested.
		
			-- ORDERED LIST
			when regexp_instr(l_row_in(i), '(\A\s*?[0-9]+\.\s)(.*)') > 0 then
				l_ol_row := l_ol_row + 1;
				l_row_out := regexp_replace(l_row_in(i),'(\A\s*?[0-9]+\.\s)(.*)','<li>\2</li>');
				if l_ol_row = 1 then
					l_row_out := l_newline || '<ol>' || l_newline || l_row_out;
					l_in_ol := true;
				end if;

			-- UNORDERED LIST
			when ltrim(substr(l_row_in(i),1,2)) in ('+ ', '* ', '- ') then
				l_ul_row := l_ul_row + 1;
				l_row_out := regexp_replace( l_row_in(i),'(\A\s|\+|\-|\*)(\s)(.*)','<li>\3</li>');
				if l_ul_row = 1 then
					l_row_out := l_newline || '<ul>' || l_newline || l_row_out;
					l_in_ul := true;
				end if;

			-- BLOCKQUOTE
			when ltrim(substr(l_row_in(i),1,2)) = '> ' then
				l_blockq_row := l_blockq_row + 1;
				l_row_out := ltrim(substr(l_row_in(i),3));
				if l_blockq_row = 1 then
					l_row_out := '<blockquote>' || l_row_out;
					l_in_blockq := true;
				end if;

			-- Code Block
			when ltrim(substr(l_row_in(i),1,3)) = '```' then
				l_code_row := l_code_row + 1;
				--l_row_out := ltrim(substr(l_row_in(i),4)); you can skip this row
				if l_code_row = 1 then
					l_row_out := '<pre>' || l_newline || '<code>';
					l_in_code := true;
				else
					if l_in_code  then
						l_row_out := '</code>' || l_newline || '</pre>';
						l_in_code := false;
					end if;
				end if;
				
			-- TABLE
			when substr(l_row_in(i),1,1) = '|' then
				l_table_row := l_table_row + 1;
				if l_table_row = 1 then
					l_text_out 	:= l_text_out || l_newline ||  '<table>' ;
					
					l_in_table := true;
					-- look to the next row for column headers
					if substr(l_row_in(i + 1), 1,3) in ('|--','| -','|:-') then
						-- reinitialize the column array
						l_column.delete;
						l_pipe_count := regexp_count(l_row_in(i),'\|');
						l_column_count := l_pipe_count - 1;
						for c in 1 .. l_pipe_count loop
							if c < l_pipe_count then
								-- left side of column, don't bother with last
								l_left_pos 			:= instr(l_row_in(i + 1),'|', 1, c); -- find the pipe
								l_left_side			:= substr(l_row_in(i + 1),l_left_pos, 2);
							
								l_right_pos 		:= instr(l_row_in(i + 1),'|', 1, c + 1); -- find the pipe
								l_right_side		:= substr(l_row_in(i + 1),l_right_pos - 1 , 2);
								case
									when trim(l_left_side) = '|' and trim(l_right_side) = '|' then
										l_column(c) := 'left';
									when trim(l_left_side) = '|:' and trim(l_right_side) = ':|' then										
										l_column(c) := 'center';
									when trim(l_left_side) = '|' and trim(l_right_side) = ':|' then										
										l_column(c) := 'right';
									else
										l_column(c) := 'left';
								end case;
							end if; -- c < pipe_count
						end loop; -- columns for headers
						l_row_out := l_row_out || '<thead>' ;
					end if; -- header row with |--, | -, |:-, etc
					-- loop through the columns in the header
					if l_column_count is  null then
						l_pipe_count := regexp_count(l_row_in(i),'\|');
						l_column_count := l_pipe_count - 1;
					end if; -- column count is null
					l_row_out := l_row_out || l_newline || '<tr>' || l_newline ;
					for c in 1 .. l_column_count loop
						l_left_pos 			:= instr(l_row_in(i),'|', 1, c); -- find the pipe
						l_left_side			:= substr(l_row_in(i),l_left_pos, 2);
							
						l_right_pos 		:= instr(l_row_in(i),'|', 1, c + 1); -- find the pipe
						l_right_side		:= substr(l_row_in(i),l_right_pos - 1 , 2);
						l_row_out := column_align (
							P_COLUMN			=> l_column,
							P_INDEX				=> c,
							P_ROW_OUT			=> l_row_out,
							P_HEADER			=> 'h'
							);
						l_row_out := l_row_out || trim(substr(l_row_in(i),l_left_pos + 1, (l_right_pos - l_left_pos - 1)));
						l_row_out := l_row_out || '</th>' || l_newline;
					end loop; -- columns in the header
					l_row_out := l_row_out ||  '</tr>' || l_newline;
					if instr(l_row_out,'<thead>') > 0 then
						l_row_out := l_row_out ||  '</thead>' || l_newline;
					end if; -- is <thead> included
					l_row_out := l_row_out || '<tbody>' || l_newline;
				else -- table row = 1
					-- skip the dash line/header defintions
					if substr(l_row_in(i), 1,3) not in ('|--','| -','|:-') then	
						-- loop through the columns in the header
						l_row_out := l_row_out || l_newline || '<tr>' || l_newline ;
						for c in 1 .. l_column_count loop
							l_left_pos 			:= instr(l_row_in(i),'|', 1, c); -- find the pipe
							l_left_side			:= substr(l_row_in(i),l_left_pos, 2);
								
							l_right_pos 		:= instr(l_row_in(i),'|', 1, c + 1); -- find the pipe
							l_right_side		:= substr(l_row_in(i),l_right_pos - 1 , 2);
						l_row_out := column_align (
							P_COLUMN			=> l_column,
							P_INDEX				=> c,
							P_ROW_OUT			=> l_row_out,
							P_HEADER			=> 'd'
							);
							l_row_out := l_row_out || trim(substr(l_row_in(i),l_left_pos + 1, (l_right_pos - l_left_pos - 1)));
							l_row_out := l_row_out || '</td>' || l_newline;
						end loop; -- columns in the header
						l_row_out := l_row_out ||  '</tr>';
					else
						l_skip_line := true; -- do not capture the header break
					end if; -- not a header
				end if; -- table row = 1
			else 
				-- button up tags
				if l_in_ul then
					l_row_out := '</ul>' || l_newline || l_row_in(i);
					l_in_ul := false;
					l_ul_row := 0;
				end if; -- end list
				if l_in_ol then
					l_row_out := '</ol>' || l_newline || l_row_in(i);
					l_in_ol := false;
					l_ol_row := 0;
				end if; -- end list
				if l_in_blockq then
					l_row_out := '</blockquote>' || l_newline || l_row_in(i);
					l_in_blockq := false;
					l_blockq_row := 0;
				end if; -- end list
				if l_in_table then
					l_row_out := '</tbody>' || l_newline || '</table>' || l_newline || l_row_in(i);
					l_in_table := false;
					l_table_row := 0;
					l_column.delete;
				end if;
		end case;
		if not l_skip_line then -- need to skip the line in a table between header and body
			if l_row_out is null then
				l_row_out := l_row_in(i);
			end if;
			
			-- inline text formatting
			-- don't use or '|' for expression because both sides must match
			l_row_out := regexp_replace(l_row_out,'(\*\*)(.*?)(\*\*)','<strong>' || '\2' || '</strong>');
			l_row_out := regexp_replace(l_row_out,'(__)(.*?)(__)','<strong>' || '\2' || '</strong>');
			l_row_out := regexp_replace(l_row_out,'(_)(.*?)(_)','<em>' || '\2' || '</em>');
			l_row_out := regexp_replace(l_row_out,'(\*)(.*?)(\*)','<em>' || '\2' || '</em>');
			l_row_out := regexp_replace(l_row_out,'(\~\~)(.*?)(\~\~)','<strike>' || '\2' || '</strike>');
			l_row_out := regexp_replace(l_row_out,'(`)(.*?)(`)','<code>' || '\2' || '</code>');
			l_row_out := regexp_replace(l_row_out,'!\[([^\[]+)\]\(([^\)]+)\)','<img src="\2" alt="\1">\1</a>');
			l_row_out := regexp_replace(l_row_out,'\[([^\[]+)\]\(([^\)]+)\)','<a href="\2">\1</a>');
			
			if not l_in_table then
				l_row_out := regexp_replace(l_row_out,'-{3,}','<hr />');
			end if;
	
			if l_text_out is null then
				l_text_out 	:= l_row_out;
			else
--				if l_in_code then
--					l_text_out 	:= l_text_out || l_newline || l_newline || l_row_out;
--				else
					l_text_out 	:= l_text_out || l_newline ||l_row_out;
--				end if; -- in code block
			end if; -- l_text_out null
		else -- skip line
			l_skip_line := false;
		end if; -- skip line
		l_row_out 	:= '';
	end loop;
end if; -- text is less than 32K

--l_text_out := crlf_2_br(l_text_out);
--dbms_output.put_line(l_text_out);
-- you can drop the text into a CLOB use as you see fit.
return l_text_out;
end md_2_html;


function md_2_html (
	P_TEXT			in varchar2
	) return varchar2
-------------------------------------------------------------------------------
-- FUNCTION				md_2_html
--	returns				varchar2
-- converts markdown to HTML in a clob that is less than 32K
-- notes:
--		As of April 2017, the UL/OL process does not accommodate nesting
--		And tables do require a leading and trailing pipe '|'
--
-- Written				24APR2017
--								cmoore
--
-- Modifications:
--
--
--
-------------------------------------------------------------------------------		
as
  l_text 						varchar2(32767);
  l_row_in					wwv_flow_global.vc_arr2;
	l_column					wwv_flow_global.vc_arr2;
	l_pipe_count			pls_integer;
	l_column_count		pls_integer;
	l_left_pos				pls_integer;
	l_right_pos				pls_integer;
	l_left_side				varchar2(5);
	l_right_side			varchar2(5);
	l_row_out					varchar2(4000);
	l_text_out				varchar2(32767);
	l_in_ol						boolean	:= false;
	l_in_ul						boolean	:= false;
	l_in_table				boolean	:= false;
	l_in_blockq				boolean := false;
	l_skip_line				boolean	:= false;
	l_newline					varchar2(4);
	l_ol_row					number 	:= 0;
	l_ul_row					number 	:= 0;
	l_table_row				number	:= 0;
	l_blockq_row			number	:= 0;
begin
if dbms_lob.getlength(P_TEXT) < 32000 then
	--l_text := crlf_2_nl(P_TEXT);
	l_text := P_TEXT;
	case 
		when instr(l_text, crlf) > 0 then
			l_row_in := apex_util.string_to_table(l_text, crlf);
			l_newline	:= crlf;
		when instr(l_text, cr) > 0 then
			l_row_in := apex_util.string_to_table(l_text, cr);
			l_newline	:= cr;
		when instr(l_text, nl) > 0 then
			l_row_in := apex_util.string_to_table(l_text, nl);
			l_newline	:= nl;
		else
			null;
	end case;
		
  for i in 1 .. l_row_in.count loop
	
		-- line type
		case
			-- HEADER
			when substr(l_row_in(i),1,1) = '#' then
				l_row_out := h(l_row_in(i));

				-- Note on lists, at present, these are NOT nested.
		
			-- ORDERED LIST
			when regexp_instr(l_row_in(i), '(\A\s*?[0-9]+\.\s)(.*)') > 0 then
				l_ol_row := l_ol_row + 1;
				l_row_out := regexp_replace(l_row_in(i),'(\A\s*?[0-9]+\.\s)(.*)','<li>\2</li>');
				if l_ol_row = 1 then
					l_row_out := l_newline || '<ol>' || l_newline || l_row_out;
					l_in_ol := true;
				end if;

			-- UNORDERED LIST
			when ltrim(substr(l_row_in(i),1,2)) in ('* ', '- ', '+ ') then
				l_ul_row := l_ul_row + 1;
				l_row_out := regexp_replace( l_row_in(i),'(\A\s\+|\-|\*)(\s)(.*)','<li>\3</li>');
				if l_ul_row = 1 then
					l_row_out := l_newline || '<ul>' || l_newline || l_row_out;
					l_in_ul := true;
				end if;

			-- BLOCKQUOTE
			when ltrim(substr(l_row_in(i),1,2)) = '> ' then
				l_blockq_row := l_blockq_row + 1;
				l_row_out := ltrim(substr(l_row_in(i),3));
				if l_blockq_row = 1 then
					l_row_out := '<blockquote>' || l_row_out;
					l_in_blockq := true;
				end if;
				
			-- TABLE
			when substr(l_row_in(i),1,1) = '|' then
				l_table_row := l_table_row + 1;
				if l_table_row = 1 then
					l_text_out 	:= l_text_out || l_newline ||  '<table>' ;
					
					l_in_table := true;
					-- look to the next row for column headers
					if substr(l_row_in(i + 1), 1,3) in ('|--','| -','|:-') then
						-- reinitialize the column array
						l_column.delete;
						l_pipe_count := regexp_count(l_row_in(i),'\|');
						l_column_count := l_pipe_count - 1;
						for c in 1 .. l_pipe_count loop
							if c < l_pipe_count then
								-- left side of column, don't bother with last
								l_left_pos 			:= instr(l_row_in(i + 1),'|', 1, c); -- find the pipe
								l_left_side			:= substr(l_row_in(i + 1),l_left_pos, 2);
							
								l_right_pos 		:= instr(l_row_in(i + 1),'|', 1, c + 1); -- find the pipe
								l_right_side		:= substr(l_row_in(i + 1),l_right_pos - 1 , 2);
								case
									when trim(l_left_side) = '|' and trim(l_right_side) = '|' then
										l_column(c) := 'left';
									when trim(l_left_side) = '|:' and trim(l_right_side) = ':|' then										
										l_column(c) := 'center';
									when trim(l_left_side) = '|' and trim(l_right_side) = ':|' then										
										l_column(c) := 'right';
									else
										l_column(c) := 'left';
								end case;
							end if; -- c < pipe_count
						end loop; -- columns for headers
						l_row_out := l_row_out || '<thead>' ;
					end if; -- header row with |--, | -, |:-, etc
					-- loop through the columns in the header
					if l_column_count is  null then
						l_pipe_count := regexp_count(l_row_in(i),'\|');
						l_column_count := l_pipe_count - 1;
					end if; -- column count is null
					l_row_out := l_row_out || l_newline || '<tr>' || l_newline ;
					for c in 1 .. l_column_count loop
						l_left_pos 			:= instr(l_row_in(i),'|', 1, c); -- find the pipe
						l_left_side			:= substr(l_row_in(i),l_left_pos, 2);
							
						l_right_pos 		:= instr(l_row_in(i),'|', 1, c + 1); -- find the pipe
						l_right_side		:= substr(l_row_in(i),l_right_pos - 1 , 2);
						l_row_out := column_align (
							P_COLUMN			=> l_column,
							P_INDEX				=> c,
							P_ROW_OUT			=> l_row_out,
							P_HEADER			=> 'h'
							);
						l_row_out := l_row_out || trim(substr(l_row_in(i),l_left_pos + 1, (l_right_pos - l_left_pos - 1)));
						l_row_out := l_row_out || '</th>' || l_newline;
					end loop; -- columns in the header
					l_row_out := l_row_out ||  '</tr>' || l_newline;
					if instr(l_row_out,'<thead>') > 0 then
						l_row_out := l_row_out ||  '</thead>' || l_newline;
					end if; -- is <thead> included
					l_row_out := l_row_out || '<tbody>' || l_newline;
				else -- table row = 1
					-- skip the dash line/header defintions
					if substr(l_row_in(i), 1,3) not in ('|--','| -','|:-') then	
						-- loop through the columns in the header
						l_row_out := l_row_out || l_newline || '<tr>' || l_newline ;
						for c in 1 .. l_column_count loop
							l_left_pos 			:= instr(l_row_in(i),'|', 1, c); -- find the pipe
							l_left_side			:= substr(l_row_in(i),l_left_pos, 2);
								
							l_right_pos 		:= instr(l_row_in(i),'|', 1, c + 1); -- find the pipe
							l_right_side		:= substr(l_row_in(i),l_right_pos - 1 , 2);
						l_row_out := column_align (
							P_COLUMN			=> l_column,
							P_INDEX				=> c,
							P_ROW_OUT			=> l_row_out,
							P_HEADER			=> 'd'
							);
							l_row_out := l_row_out || trim(substr(l_row_in(i),l_left_pos + 1, (l_right_pos - l_left_pos - 1)));
							l_row_out := l_row_out || '</td>' || l_newline;
						end loop; -- columns in the header
						l_row_out := l_row_out ||  '</tr>';
					else
						l_skip_line := true; -- do not capture the header break
					end if; -- not a header
				end if; -- table row = 1
			else 
				-- button up tags
				if l_in_ul then
					l_row_out := '</ul>' || l_newline || l_row_in(i);
					l_in_ul := false;
					l_ul_row := 0;
				end if; -- end list
				if l_in_ol then
					l_row_out := '</ol>' || l_newline || l_row_in(i);
					l_in_ol := false;
					l_ol_row := 0;
				end if; -- end list
				if l_in_blockq then
					l_row_out := '</blockquote>' || l_newline || l_row_in(i);
					l_in_blockq := false;
					l_blockq_row := 0;
				end if; -- end list
				if l_in_table then
					l_row_out := '</tbody>' || l_newline || '</table>' || l_newline || l_row_in(i);
					l_in_table := false;
					l_table_row := 0;			-- reinit the table row count
					l_column.delete; 			-- reinit the column alignment
					l_column_count := 0; 	-- reinit the column count
				end if;
		end case;
		if not l_skip_line then -- need to skip the line in a table between header and body
			if l_row_out is null then
				l_row_out := l_row_in(i);
			end if;
			
			-- inline text formatting
			-- don't use or '|' for expression because both sides must match
			l_row_out := regexp_replace(l_row_out,'(\*\*)(.*?)(\*\*)','<strong>' || '\2' || '</strong>');
			l_row_out := regexp_replace(l_row_out,'(__)(.*?)(__)','<strong>' || '\2' || '</strong>');
			l_row_out := regexp_replace(l_row_out,'(_)(.*?)(_)','<em>' || '\2' || '</em>');
			l_row_out := regexp_replace(l_row_out,'(\*)(.*?)(\*)','<em>' || '\2' || '</em>');
			l_row_out := regexp_replace(l_row_out,'(\~\~)(.*?)(\~\~)','<strike>' || '\2' || '</strike>');
			l_row_out := regexp_replace(l_row_out,'(`)(.*?)(`)','<code>' || '\2' || '</code>');
			l_row_out := regexp_replace(l_row_out,'!\[([^\[]+)\]\(([^\)]+)\)','<img src="\2" alt="\1">\1</a>');
			l_row_out := regexp_replace(l_row_out,'\[([^\[]+)\]\(([^\)]+)\)','<a href="\2">\1</a>');
			
			if not l_in_table then
				l_row_out := regexp_replace(l_row_out,'-{3,}','<hr />');
			end if;
	
			if l_text_out is null then
				l_text_out 	:= l_row_out;
			else
				l_text_out 	:= l_text_out || l_newline ||l_row_out;
			end if; -- 
		else -- skip line
			l_skip_line := false;
		end if; -- skip line
		l_row_out 	:= '';
	end loop;
end if; -- text is less than 32K
l_text_out := crlf_2_br(l_text_out);
--dbms_output.put_line(l_text_out);
-- you can drop the text into a varchar2 use as you see fit.
return l_text_out;
end md_2_html;

end markdown_2_html;
