-- login.sql
-- SQL*Plus user login startup file.
--
-- This script is automatically run after glogin.sql
--
-- SQLPlus spits shit in "pages" and you can't turn it
-- off. This is mostly to address that bullshit.

-- Page height (output rows) to allowed maximum
SET PAGESIZE 50000

-- Page width (output cols) to allowed maximum
SET LINESIZE 32767

-- Disable line wrapping
SET WRAP ON

-- Column separator
SET COLSEP " | "

-- "N rows selected" footer
SET FEEDBACK ON
