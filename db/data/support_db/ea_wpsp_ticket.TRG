TYPE=TRIGGERS
triggers='CREATE DEFINER=```root```@```%``` TRIGGER `SLA_CREATOR` AFTER INSERT ON `ea_wpsp_ticket` FOR EACH ROW BEGIN\n declare SLA date;\n declare nextMonday date;\n declare nextDay date;\n declare today date; \n\n set @nextDay=concat(ADDDATE(NOW(), +1), \' 10:00:00\');\n set @nextMonday=concat(DATE_ADD(NOW(), INTERVAL (9 - DAYOFWEEK(NOW())) DAY), \' 10:00:00\');\n set @today=concat(NOW(), \' 10:00:00\');\n\n if (new.cat_id in (1)) then -- Bug\n  set @SLA="2:00:00.000000";\n elseif (new.cat_id=8) then -- Op. Task\n  set @SLA="24:00:00.000000";\n else    \n  set @SLA="00:00:00.000000";\n end if;\n\nif (new.priority_id in (1)) then\n    INSERT INTO support_db.be_sla_manager\n   (ticket_id ,end_time ) values\n    (new.id,ADDTIME(NOW(), "24:00:00.000000"));\n end if;\nEND'
sql_modes=0
definers='`root`@`%`'
client_cs_names='utf8mb4'
connection_cl_names='utf8mb4_unicode_ci'
db_cl_names='latin1_swedish_ci'
