<?php
	include("inc/api.php");
	include("inc/functions.php");
	class WEB_SERVICE extends API {
		const DB_SERVER = "localhost";
		const DB_USER = "apollo90_chuck";
		const DB_PASSWORD = "yiI*p7Cv?mvCsav";
		const DB = "apollo90_cruiterzm";
		
		public function __construct() {
			parent::__construct();
			$this->dbConnect();
			//$this->dbConnect();
			/*      
			//SECURITY MODULE BEFORE API ACCESS
			
			$APIKey = new Models\APIKey();
			$User = new Models\User();
			if (!array_key_exists('apiKey', $this->request)) {
				throw new Exception('No API Key provided');
			} else if (!$APIKey->verifyKey($this->request['apiKey'], $origin)) {
				throw new Exception('Invalid API Key');
			} else if (array_key_exists('token', $this->request) &&
				 !$User->get('token', $this->request['token'])) {

				throw new Exception('Invalid User Token');
			} 
			$this->User = $User;
			*/
		}
		private function dbConnect(){
			$this->db = mysql_connect(self::DB_SERVER,self::DB_USER,self::DB_PASSWORD) or die("Could not connect to the server. Contact the development team for assistance.");
			mysql_select_db(self::DB,$this->db) or die("Could not open the database. Contact the development team for assistance.");
		}
		//process API parser for all requests within the system
		public function processAPI(){

			$func = explode("/",strtolower($_REQUEST['request']));
			//handle cals made to the users/ directory
			if($func[0] == "users"){
				if($func[1] == "login"){
					$this->login();
				}
				else{
					$this->_response('','',404);
				}
			}
			//requests aimed at the /quotation directory
			else if($func[0] == "quotation"){
				if($func[1] == "requests"){
					if($func[2] == "add"){
						$this->add_quotation_request_demo();
					}
					else if($func[2] == "get"){
						$this->get_quotation_request();
					}
					else{
						$this->_response('','',404);
					}
				}
				else{
					$this->_response('','',404);
				}
			}
			//if requested path is not found throw a not found response.
			else{
				$this->_response('','',404);
			}	
		}
		/**
		 * user login end point
		 */
		 public function login_user() {
			 
			if ($this->_method() != 'POST') {
				$this->_response('','',406);
			}
			$this->_response('Apollo, everything is okay!','',200);			
		 }





		 /****/

         //add quotation request
         public function add_quotation_request(){

			if($this->_method() != 'POST') {
				$this->_response('','',406);
			} 
			if(!isset($_REQUEST["request_type"]) || empty($_REQUEST["request_type"])) {
				$this->_response('Provide a quotation request type','',400);
			}

            //requestor information 






            //
			if(!isset($_REQUEST["quotation_object"]) || empty($_REQUEST["quotation_object"])) {
				$this->_response('Provide applicant id','',400);
			}
		    /*	
		        if(isJSON($_REQUEST["quotation_object"])){
					$this->_response('Invalid quotation object','',400);
			    }
			*/
			//creating new account after finding out the requesting one doesnt existing



			//
			$insert_quotation_request = mysql_query("INSERT INTO quotation_request(
						`details`,
						`date_created`,
						`type`,
						`activated`
						) 
					VALUES (
						'".$_REQUEST["quotation_object"]."',
						NOW(),
					    '".$_REQUEST["request_type"]."',
						1)")
					or die(mysql_error());

					if(mysql_affected_rows()<1){
			
						$this->_response('Could not update profile status at the moment.','',400);

					}else{
						//make an email copy to all intrested companies

				        //response about successful
						$this->_response('Quotation inquiry successfully sent','',200);		
					}

		}
		public function add_quotation_request_demo(){

			if($this->_method() != 'POST') {
				$this->_response('','',406);
			} 
			//die(print_r($_REQUEST));
/* 			 

 [year] => 1994
    [model] => Corolla
    [description] => Pick up
    [make] => Toyota
    [cover] => 1
    [fullname] => Charles
    [email] => mutalecharles@gmail.com
    [id] => 12223333
    [mobile] => 0987777777
    [license_type] => 1
    [driver_type] => regular

        "year" :details.vehicle_year,
						"model" : details.vehicle_model,
						"description" : details.vehicle_description,
						"make" : details.vehicle_make,
						"cover" : details.cover_type,
						"fullname": details.fullname,
						"email": details.email,
						"id": details.id,
						"mobile": details.mobile,
						"license_type":details.license_type,
						"driver_type" : "regular" */
			if(!isset($_REQUEST["email"]) || empty($_REQUEST["email"])) {
				$this->_response('Missing details','',400);
			}		
			if(!isset($_REQUEST["fullname"]) || empty($_REQUEST["fullname"])) {
				$this->_response('Missing details','',400);
			}		
			if(!isset($_REQUEST["id"]) || empty($_REQUEST["id"])) {
				$this->_response('Missing details','',400);
			}		
			if(!isset($_REQUEST["mobile"]) || empty($_REQUEST["mobile"])) {
				$this->_response('Missing details','',400);
			}		
			if(!isset($_REQUEST["license_type"]) || empty($_REQUEST["license_type"])) {
				$this->_response('Missing details','',400);
			}		
			if(!isset($_REQUEST["driver_type"]) || empty($_REQUEST["driver_type"])) {
				$this->_response('Missing details','',400);
			}		
			if(!isset($_REQUEST["cover"]) || empty($_REQUEST["cover"])) {
				$this->_response('Missing details','',400);
			}		
			if(!isset($_REQUEST["make"]) || empty($_REQUEST["make"])) {
				$this->_response('Missing details','',400);
			}		
			if(!isset($_REQUEST["description"]) || empty($_REQUEST["description"])) {
				$this->_response('Missing details','',400);
			}		
			if(!isset($_REQUEST["model"]) || empty($_REQUEST["model"])) {
				$this->_response('Missing details','',400);
			}		
			if(!isset($_REQUEST["year"]) || empty($_REQUEST["year"])) {
				$this->_response('Missing details','',400);
			}

            //requestor information 
	





            //send out email
			$headers  = "From: hello@mutalecharles.com \r\n";
			$headers .= "Content-type: text/html; charset=iso-8859-1 \r\n";
			$subject = "New Quotation Request";
			$emsg="A new quotation was submitted. <br>";
			$emsg .="Type: Motor Insurance <br>Details:<br>Vehicle Details<br/>";
			$emsg .="Year :".$_REQUEST["year"]."<br>Model :".$_REQUEST["model"]."<br>Make : ".$_REQUEST["make"]."<br>Description : ".$_REQUEST["description"]."<br>Cover :".$_REQUEST["cover"]."<br>License type:".$_REQUEST["license_type"]."<br>Driver type : regular<br/><br/>Customer Information<br>Name: ".$_REQUEST["fullname"]."<br>Email:".$_REQUEST["email"]."<br>ID:".$_REQUEST["id"]."<br>Mobile: ".$_REQUEST["mobile"]."<br>";
			//$emsg .=''.$_SESSION['user_name'].' '.$_SESSION['last_name'].' at '.$_SESSION['user_email'].'.';
			mail("mutalecharles@gmail.com",$subject,$emsg,$headers);
			mail("cmusonda944@gmail.com",$subject,$emsg,$headers);
			mail("kasomakabwe@gmail.com",$subject,$emsg,$headers);
			$this->_response('Quotation successfully added.','', 200);	
		}
         ////////////////////////////////////////////////////////////////////////////////////

		}
		if (!array_key_exists('HTTP_ORIGIN', $_SERVER)) {
			$_SERVER['HTTP_ORIGIN'] = $_SERVER['SERVER_NAME'];
		} 
		try {
			$API = new WEB_SERVICE($_REQUEST['request'], $_SERVER['HTTP_ORIGIN']);
			$API->processAPI();
		}
		catch (Exception $e) {
			echo json_encode(Array('error' => $e->getMessage())); 
		}
?>