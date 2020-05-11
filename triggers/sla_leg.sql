DELIMITER ;
/*!50003 CREATE*/ /*!50017 DEFINER=`devops`@`%`*/ /*!50003 TRIGGER on_ticket_creation after insert                   
 ON support_db.ea_wpsp_ticket
 FOR EACH ROW
 BEGIN

 declare SLA date;
 declare nextMonday date;
 declare nextDay date;
 declare today date;

 set @nextDay=concat(ADDDATE(NOW(), +1), ' 10:00:00');
 set @nextMonday=concat(DATE_ADD(NOW(), INTERVAL (9 - DAYOFWEEK(NOW())) DAY), ' 10:00:00');
 set @today=concat(NOW(), ' 10:00:00');

 if (new.cat_id in (1)) then -- Bug
  set @SLA="2:00:00.000000";
  --insert into erp_bug_support_system.be_mail_queue
  --(send_address,mail_type,ticket_id,status,ticket_status,system) values
  --(new.cust12,3,new.id,0,"legacy","legacy");
 elseif (new.cat_id=8) then -- Op. Task
  set @SLA="24:00:00.000000";
  --insert into erp_bug_support_system.be_mail_queue
     --(send_address,mail_type,ticket_id,status,ticket_status,system) values
     --("janani.vamathevan@ikman.lk@ikman.lk",3,new.id,0,"legacy","legacy");
 --elseif (new.cat_id=6) then 
  --set @SLA="3:00:00.000000";
  --insert into erp_bug_support_system.be_mail_queue
     --(send_address,mail_type,ticket_id,status,ticket_status,system) values
     --("methsala.atthanayake@ikman.lk",3,new.id,0,"legacy","legacy");
 else 
  set @SLA="00:00:00.000000";
 end if;

if (new.priority_id in (1) then 
    INSERT INTO erp_access_req.be_sla_manager
   (ticket_id ,end_time ) values
    (new.id,ADDTIME(NOW(), "24:00:00.000000"));
 end if;

END */;; 
DELIMITER ;

