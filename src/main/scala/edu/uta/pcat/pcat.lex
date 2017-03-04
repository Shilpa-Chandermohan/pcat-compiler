/********************************************************************************
*
* File: pcat.lex
* The PCAT scanner
*
********************************************************************************/

package edu.uta.pcat;

import java_cup.runtime.Symbol;

%%
%class PcatLex
%public
%line
%column
%cup
%state comment

%{

  private Symbol symbol ( int type ) {
    return new Symbol(type, yyline, yycolumn);
  }

  private Symbol symbol ( int type, Object value ) {
    return new Symbol(type, yyline, yycolumn, value);
  }

  public void lexical_error ( String message ) {
    throw new Error("*** Lexical Error: " + message + " (line: " + yyline
                    + ", position: " + yycolumn + ")");
  }
%}

DIGIT=[0-9]
ID=[a-zA-Z][a-zA-Z0-9_]*

%%

{DIGIT}+		{ return symbol(sym.INTEGER_LITERAL,new Integer(yytext())); }
{DIGIT}+"."{DIGIT}+	{ return symbol(sym.REAL_LITERAL,new Float(yytext())); }
[(][*][^*]*[*]+([^*)][^*]*[*]+)*[)]       { /* DO NOTHING */ }
"("          { return symbol(sym.LPAREN); }
")"          { return symbol(sym.RPAREN); }
"["           { return symbol(sym.LSQBRA); }
"]"           { return symbol(sym.RSQBRA); }
"{"          { return symbol(sym.LCUBRA); }
"}"          { return symbol(sym.RCUBRA); }
","			{ return symbol(sym.COMMA); }
"."			{ return symbol(sym.DOT); }
";"			{ return symbol(sym.SEMI); }
":"         { return symbol(sym.COLON); }
":="         { return symbol(sym.ASGN); }
"PROGRAM"         { return symbol(sym.PROGRAM); }
"IS"         { return symbol(sym.IS); }
"IF"			{ return symbol(sym.IF); }
"ELSIF"			{ return symbol(sym.ELSIF); }
"EXIT"			{ return symbol(sym.EXIT); }
"LOOP"			{ return symbol(sym.LOOP); }
"MOD"			{ return symbol(sym.MOD); }
"NOT"			{ return symbol(sym.NOT); }
"OR"			{ return symbol(sym.OR); }
"FOR"			{ return symbol(sym.FOR); }
"TO"			{ return symbol(sym.TO); }
"RECORD"			{ return symbol(sym.RECORD); }
"THEN"			{ return symbol(sym.THEN); }
"ELSE"			{ return symbol(sym.ELSE); }
"WHILE"			{ return symbol(sym.WHILE); }
"BY"			{ return symbol(sym.BY); }
"DIV"			{ return symbol(sym.DIV); }
"DO"			{ return symbol(sym.DO); }
"ARRAY"         { return symbol(sym.ARRAY); }
"AND"         { return symbol(sym.AND); }
"RETURN"			{ return symbol(sym.RETURN); }
"PROCEDURE"         { return symbol(sym.PROCEDURE); }
"WRITE"         { return symbol(sym.WRITE); }
"READ"         { return symbol(sym.READ); }
"END"         { return symbol(sym.END); }
"BEGIN"         { return symbol(sym.BEGIN); }
"TYPE"			{ return symbol(sym.TYPE); }
"OF"			{ return symbol(sym.OF); }
"VAR"        { return symbol(sym.VAR); }
"+"			{ return symbol(sym.PLUS); }
"*"			{ return symbol(sym.TIMES); }
"-"			{ return symbol(sym.MINUS); }
"/"			{ return symbol(sym.SLASH); }
"="			{ return symbol(sym.EQ); }
"<"			{ return symbol(sym.LT); }
">"			{ return symbol(sym.GT); }
"<="			{ return symbol(sym.LEQ); }
"<>"			{ return symbol(sym.NEQ); }
">="			{ return symbol(sym.GEQ); }
{ID}			{ return symbol(sym.ID,yytext()); }
\"[^\"]*\"		{ return symbol(sym.STRING_LITERAL,yytext().substring(1,yytext().length()-1)); }
[ \t\r\n\f]      { /* ignore white spaces.*/ }
.               { lexical_error("Illegal character"); }
