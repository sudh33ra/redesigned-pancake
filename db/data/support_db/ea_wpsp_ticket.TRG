TYPE=TRIGGERS
triggers='CREATE DEFINER=`root`@`%` TRIGGER `SLA_CREATOR` AFTER INSERT ON `ea_wpsp_ticket` FOR EACH ROW BEGIN\n \n declare SLA date;\n \n if (new.priority_id=2) then\n set @SLA="8:00:00.000000";\n elseif (new.priority_id=3) then\n set @SLA="48:00:00.000000";\n else\n set @SLA="00:00:00.000000";\n end if;\n\n INSERT INTO support_db.be_sla_manager\n (ticket_id ,end_time) values\n (new.id,ADDTIME(new.create_time, @SLA));\n\nEND'
sql_modes=0
definers='root@%'
client_cs_names='utf8mb4'
connection_cl_names='utf8mb4_unicode_ci'
db_cl_names='latin1_swedish_ci'
