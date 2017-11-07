version = "1.3.3";

apps =
(  { name="apache";
     type="elf";
     alias=["httpd"];
     conf=["conf/httpd.conf"];
     cnfarg="-f";
     sigs=(
       { patn="\\xA1.{4,4}(\\x55)?\\x85\\xC0.{0,2}\\x75.{1,1}\\xB8.{5,5}\\xC3";
         offs=-6;
         mstr="Apache/\\d+\\.\\d+(\\.\\d+)?";
         class="elf32";
       },
       { patn="\\xA1.{4,4}\\x83\\x3D.{4,4}\\x00.{2,2}\\xB8.{8,8}\\xC9\\xC3";
         offs=-10;
         mstr="Apache/\\d+\\.\\d+(\\.\\d+)?";
         class="elf32";
       },
       { patn="\\xA1.{4,4}\\x55\\x89\\xE5\\x85\\xC0.{2,2}\\x5D\\xC3\\x89\\xF6\\x5D\\xB8.{4,4}\\xC3";
         offs=-5;
         mstr="Apache/\\d+\\.\\d+(\\.\\d+)?";
         class="elf32";
       },
       { patn="\\xA1.{4,4}\\x89\\x45.{1,1}\\x83\\x3D.{4,4}\\x00.{2,2}\\xC7\\x45.{5,5}\\x8B\\x45.{1,1}\\xC9\\xC3";
         offs=-9;
         mstr="Apache/\\d+\\.\\d+(\\.\\d+)?";
         class="elf32";
       },
       { patn="\\xC7\\x04\\x24.{4,4}\\xE8.{4,4}\\xEB\\x0C\\xC7\\x04\\x24.{4,4}\\xE8";
         offs=-5;
         mstr="Apache/\\d+\\.\\d+(\\.\\d+)?";
         class="elf32";
       },
       { patn="\\x48\\x8B\\x05.{4,4}\\xBA.{4,4}\\x48\\x85\\xC0";
         offs=8;
         mstr="Apache/\\d+\\.\\d+(\\.\\d+)?";
         class="elf64";
       },
       { patn="\\xBA.{4,4}\\x48\\x85\\xC0\\x48\\x0F\\x44\\xC2\\xC3";
         offs=1;
         mstr="Apache/\\d+\\.\\d+(\\.\\d+)?";
         class="elf64";
       } );
   },

   { name="mysqld";
     type="elf";
     alias=["mysqld"];
     conf=["/etc/my.cnf"];
     cnfarg="--defaults-file";
     sigs=(
       { patn="(\\x00{4,4}\\xC7\\x44\\x24.{5,5}\\xC7\\x44\\x24.{5,5}\\xC7\\x04\\x24.{4,4}\\xE8.{4,4}\\x80\\x3D";
         offs=16;
         mstr="^\\d+\\.\\d+(\\.\\d+)?";
         class="elf32";
       },
       { patn="(\\x6A\\x00(\\x68.{4,4}){3,3}\\xE8.{4,4}\\x83\\xC4";
         offs=8;
         mstr="^\\d+\\.\\d+(\\.\\d+)?";
         class="elf32";
       },
       { patn="(\\x80\\x3D.{4,4}\\x00(\\x75|\\x74).{1,1}){2,2}.{3,17}\\x68.{4,4}\\x68.{4,4}\\xE8";
         offs=-5;
         mstr="^\\d+\\.\\d+(\\.\\d+)?";
         class="elf32";
       },
       { patn="(\\xC7\\x44\\x24.{5,5}){3,4}\\x89\\x44\\x24\\x04\\xC7.{6,6}\\xE8";
         offs=-16;
         mstr="^\\d+\\.\\d+(\\.\\d+)?";
         class="elf32";
       },
       { patn="\\xBA.{4,4}\\xBE.{4,4}\\xBF.{4,4}\\xE8.{4,4}\\x80\\x3D.{4,4}\\x00\\x75";
         offs=6;
         mstr="^\\d+\\.\\d+(\\.\\d+)?";
         class="elf64";
       } );
   },

   { name="sshd";
     type="elf";
     alias=["sshd","sshd2"];
     conf=["/etc/ssh2/sshd2_config","/etc/ssh/sshd_config","/etc/ldap.conf"];
     cnfarg="-f";
     sigs=(
       { patn="\\x68.{4,4}\\x50\\x68.{10,10}\\xE8.{5,7}\\xC3";
        offs=1;
        mstr="\\d{1,2}\\.\\d{1,2}(\\.\\d{1,2}(\\.\\d{1,2})?)?";
        class="elf32";
       },
       { patn="\\xC7\\x44\\x24.{5,5}\\x89\\x44\\x24\\x08\\xC7\\x44\\x24.{5,5}\\xA1";
        offs=4;
        mstr="\\d{1,2}\\.\\d{1,2}(\\.\\d{1,2}(\\.\\d{1,2})?)?";
        class="elf32";
       },
       { patn="\\x8B\\x50.{2,2}\\x8B\\x45.{2,2}\\x68.{4,4}\\x8B\\x45.{2,2}\\x8B\\x45.{1,1}\\x50\\xE8";
        offs=9;
        mstr="\\d{1,2}\\.\\d{1,2}(\\.\\d{1,2}(\\.\\d{1,2})?)?";
        class="elf32";
       },
	{ patn="\\xC7\\x44\\x24\\x08.{4,4}\\xC7\\x44\\x24\\x04.{4,4}\\x89\\x44\\x24\\x0C";
        offs=4;
        mstr="";
        class="elf32";
       },
	{ patn="\\x83\\xC4\\x10\\x50\\x68.{4,4}\\x68";
        offs=5;
        mstr="";
        class="elf32";
       },
       { patn="\\x48\\x89\\xC1\\xBA.{4,4}\\xBE.{4,4}\\x31\\xC0\\xE8";
        offs=4;
        mstr="OpenSSH_\\d{1,2}\\.\\d{1,2}(\\.\\d{1,2})?";
        class="elf64";
       } ,
       { patn="(\\d+\\.){2}\\d+([_-]\\w+){1,}";
         offs=13;
         mstr="";
         class="rodata";
       });
   },

   { name="rsync";
     type="elf";
     alias=["rsync","rsyncd"];
     conf=["/etc/rsyncd.conf"];
     cnfarg="--config";
     sigs=(
       { patn="\\x89\\x04.{1,1}(\\xC7\\x44\\x24.{5,5}){4,4}\\xE8";
        offs=15;
        mstr="^\\d{1,2}\\.\\d{1,2}(\\.\\d{1,2}(\\.\\d{1,2})?)?";
        class="elf32";
       },
       { patn="\\x83\\xEC.{1,1}\\x89\\x44.{2,2}\\xB8.{4,4}\\x89\\x5D";
        offs=8;
        mstr="^\\d{1,2}\\.\\d{1,2}(\\.\\d{1,2}(\\.\\d{1,2})?)?";
        class="elf32";
       },
       { patn="\\x53\\x83\\xEC.{1,1}\\x6A.{1,1}\\x68.{4,4}\\x68.{4,4}\\x8B\\x5D";
        offs=7;
        mstr="^\\d{1,2}\\.\\d{1,2}(\\.\\d{1,2}(\\.\\d{1,2})?)?";
        class="elf32";
       },
       { patn="\\x6A.{1,1}(\\x68.{4,4}){3,3}\\x53\\xE8.{4,4}\\x83\\xC4";
        offs=3;
        mstr="^\\d{1,2}\\.\\d{1,2}(\\.\\d{1,2}(\\.\\d{1,2})?)?";
        class="elf32";
       },
       { patn="\\xC7\\x44\\x24\\x1C.{4,4}\\x89\\x7C\\x24\\x14\\x89\\x44\\x24\\x18\\x8B\\x45\\x0C";
        offs=4;
        mstr="";
        class="elf32";
       },
       { patn="\\x89\\xFB\\xB9.{4,4}\\xBA.{4,4}\\xBE.{4,4}\\x48\\x83\\xEC\\x10";
        offs=3;
        mstr="^\\d{1,2}\\.\\d{1,2}(\\.\\d{1,2}(\\.\\d{1,2})?)?";
        class="elf64";
       }  );
   },

   { name="php";
     type="elf";
     alias=["php"];
     conf=["lib/php.ini"];
     cnfarg="-c";
     sigs=(
       {patn="\\x6A\\x01\\x6A\\x01\\x6A\\x17\\x68.{4,4}";
         offs=7;
         mstr="\\d{1,2}\\.\\d{1,2}(\\.\\d{1,2}(\\.\\d{1,2})?)?";
         class="elf32";
       },
       {patn="\\x17\\x00\\x00\\x00\\xC7\\x04\\x24.{4,4}\\xE8.{4,4}\\xE9";
         offs=7;
         mstr="\\d{1,2}\\.\\d{1,2}(\\.\\d{1,2}(\\.\\d{1,2})?)?";
         class="elf32";
       } );
   },

   { name="squid";
     type="elf";
     alias=["squid"];
     conf=["etc/squid.conf"];
     cnfarg="-f";
     sigs=(
       {patn="[\\x0D\\xA1].{4,4}[\\x50\\x51]\\x68.{4,4}\\xE8.{4,4}\\xC7\\x04\\x24\\x00";
         offs=1;
         mstr="^\\d{1,2}\\.\\d{1,2}(\\.\\d{1,2}(\\.\\d{1,2})?)?";
         class="elf32";
       },
       {patn="\\xA1.{4,20}\\x89\\x44\\x24\\x04\\xE8.{4,4}\\xC7\\x04\\x24\\x00\\x00\\x00\\x00\\xE8";
         offs=1;
         mstr="^\\d{1,2}\\.\\d{1,2}(\\.\\d{1,2}(\\.\\d{1,2})?)?";
         class="elf32";
       },
       {patn="\\xCE\\xF2\\x47\\x00\\x00\\x00\\x00\\x00.{4,4}\\x00\\x00\\x00\\x00\\xF2\\x77\\x48\\x00\\x00\\x00\\x00\\x00";
         offs=8;
         mstr="";
         class="elf64";
       },
        {patn="\\x8D\\x46\\x70\\x50\\xE8\\x19\\x21\\xFF\\xFF\\x83\\xC4\\x1C\\x68.{4,4}\\x8D\\x5E\\x0C\\x6A\\x2F\\x53\\xE8\\x76\\xA0\\xFF\\xFF\\x83\\xC4\\x0C";
         offs=13;
         mstr="";
         class="elf32";
       },
        {patn="\\x48\\x8B\\x35.{4,4}\\xBF.{4,4}\\xBA.{4,4}\\x31\\xC0\\xE8.{4,4}\\x31\\xFF\\xE8";
         offs=3;
         mstr="^\\d{1,2}\\.\\d{1,2}(\\.\\d{1,2}(\\.\\d{1,2})?)?";
         class="elf64";
       },
       {patn="\\x03\\xF4\\x48\\x00\\x00\\x00\\x00\\x00.{4,4}\\x00\\x00\\x00\\x00\\x1A\\xEE\\x4A\\x00\\x00\\x00\\x00\\x00";
         offs=8;
         mstr="";
         class="elf64";
       },
        {patn="\\x83\\x3A\\x49\\x00\\x00\\x00\\x00\\x00.{4,4}\\x00\\x00\\x00\\x00\\x47\\x39\\x4B\\x00\\x00\\x00\\x00\\x00";
         offs=8;
         mstr="";
         class="elf64";
       });
   },

   { name="lighttpd";
     type="elf";
     alias=["lighttpd"];
     conf=["openwrt/lighttpd.conf"];
     cnfarg="-f";
     sigs=(
       {patn="\\xE8.{4,4}\\x83\\xC4.{1,1}\\x50\\x68.{4,4}\\x6A\\x01\\xE8";
         offs=10;
         mstr="^lighttpd-\\d{1,2}\\.\\d{1,2}(\\.\\d{1,2}(\\.\\d{1,2})?)?";
         class="elf32";
       },
       {patn="\\x55\\x89\\xE5\\x83\\xEC.{1,1}\\xC7\\x04\\x24.{4,4}\\xE8";
         offs=-5;
         mstr="^lighttpd-\\d{1,2}\\.\\d{1,2}(\\.\\d{1,2}(\\.\\d{1,2})?)?";
         class="elf32";
       },
       {patn="\\x89\\xE5\\xB9.{4,4}\\x83\\xEC.{1,1}\\x89\\x44\\x24\\x08";
         offs=3;
         mstr="^lighttpd-\\d{1,2}\\.\\d{1,2}(\\.\\d{1,2}(\\.\\d{1,2})?)?";
         class="elf32";
       },
       {patn="\\x00\\x00\\x00\\xC7\\x44\\x24.{5,5}\\xC7\\x04\\x24\\x01\\x00";
         offs=7;
         mstr="^lighttpd-\\d{1,2}\\.\\d{1,2}(\\.\\d{1,2}(\\.\\d{1,2})?)?";
         class="elf32";
       },
	{patn="\\xBA\\x19\\x00\\x00\\x00\\xBE.{4,4}\\x48\\x89\\xDF\\xE8";
         offs=6;
         mstr="lighttpd";
         class="elf64";
       });
   },

   { name="nginx";
     type="elf";
     alias=["nginx"];
     conf=["conf/nginx.conf"];
     cnfarg="-c";
     sigs=(
       { patn="\\x00\\x00\\x75.{1,1}\\xBE.{4,4}\\xBB.{4,4}[\\x48\\x49]\\x83";
         offs=5;
         mstr="nginx/\\d+\\.\\d+(\\.\\d+)";
         class="elf32";
       },
	{ patn="\\xC7\\x44\\x24\\x04.{4,4}\\xC7\\x04\\x24\\x00\\x00\\x00\\x00\\xE8";
         offs=4;
         mstr="nginx/\\d+\\.\\d+(\\.\\d+)";
         class="elf32";
       },
	{ patn="\\xC7\\x44\\x24\\x08\\x1D\\x00\\x00\\x00\\xC7\\x44\\x24\\x04.{4,4}\\xC7\\x04\\x24\\x02\\x00\\x00\\x00";
         offs=12;
         mstr="";
         class="elf32";
       },
	{ patn="\\x83\\xEC\\x08\\x68.{4,4}\\x6A\\x00\\xE8";
         offs=4;
         mstr="";
         class="elf32";
       },
	{ patn="\\xBE.{4,4}\\xBF\\x00\\x00\\x00\\x00\\xB8\\x00\\x00\\x00\\x00\\xE8";
         offs=1;
         mstr="nginx/\\d+\\.\\d+(\\.\\d+)";
         class="elf64";
       });
   },

   { name="qhttpd";
     type="elf";
     alias=["qhttpd","qhttpd-watchdog"];
     sym=["qhttpd_version_string"];
     conf=["conf/qhttpd.conf"];
     cnfarg="-c";
     sigs=(
	{ patn="\\xB9.{4,4}\\xBA.{4,4}\\x31\\xF6\\x31\\xDB\\x89\\x4C\\x24\\x08\\x89\\x54\\x24\\x04\\xC7";
         offs=6;
         mstr="";
         class="elf32";
       },
       { patn="\\xA1.{4,4}\\xBA.{4,4}\\x89\\x4C\\x24\\x14\\x89\\x54\\x24\\x10\\x89\\x44\\x24\\x0C\\xA1.{4,4}\\x89\\x44\\x24\\x08";
         offs=1;
         mstr="^\\d{1,2}\\.\\d{1,2}(\\.\\d{1,2}(\\.\\d{1,2})?)?";
         class="elf32";
       },
       { patn="\\x48\\x8B\\x0D.{4,4}\\x48\\x8B\\x15.{4,4}\\x41\\xB9.{4,4}\\x48\\x8B\\x3D.{4,4}\\x41\\xB8.{4,4}\\xBE.{4,4}\\x31\\xC0\\xE9";
         offs=3;
         mstr="^\\d{1,2}\\.\\d{1,2}(\\.\\d{1,2}(\\.\\d{1,2})?)?";
         class="elf64";
       }
       );
   },

 	{ name="tws_httpd";
     type="elf";
     alias=["tws_httpd","tws-watchdog"];
     sym=["qhttpd_version_string"];
     conf=["conf/tws_httpd.conf"];
     cnfarg="-c";
     sigs=(
			{ patn="\\xB9.{4,4}\\xBA.{4,4}\\x89\\x4C\\x24\\x08\\x31\\xDB\\x89\\x54\\x24\\x04\\xE8\\xF5\\xE5\\xFF\\xFF";
         offs=6;
         mstr="";
         class="elf32";
       });
   },

   { name="haproxy";
     type="elf";
     alias=["haproxy"];
     conf=["conf/haproxy.conf"];
     cnfarg="-c";
     sigs=(
       { patn="\\x55\\x89\\xE5\\x83\\xEC\\x14\\x68.{4,4}";
         offs=7;
         mstr="";
         class="elf32";
       });
   },

     
   { name="tomcat";
     type="java";
     alias=["java"];
     conf=["conf/server.xml"];
     cnfarg="";
     param="-Dcatalina.home=";
     sigs=(
       {patn="server.[a-zA-Z]+\\s*=[a-zA-Z/ \t]*\\d+\\.\\d+(\\.\\d+(\\.\\d+)?)?";
			   jar="lib/catalina.jar";
			   subn="org/apache/catalina/util/ServerInfo.properties";
		   } );
   },
   
	{ name="jetty";     
		type="java";     
		alias=["java"];     
		conf=["conf/hadoop-site.xml"];     
		cnfarg="";     
		param="-Dhadoop.home.dir=";  
		cmds=(
			{	patn="jetty-(\\d+\\.){2}\\d+";
				offs=6;
			}
		);   
		sigs=(       
			{patn="\\d+\\.\\d+(\\.\\w+(\\.\\w+)?)?";			   
				jar="start.jar";			   
				subn="META-INF/maven/org.mortbay.jetty/start/pom.properties";		   
			} 
		);   
	},

   { name="resin";
     type="java";
     alias=["java"];
     conf=["conf/resin.properties"];
     cnfarg="-conf";
     param="-Dresin.home=";
     sigs=(
       {patn="Resin(\\-|\\s+)\\d+\\.\\d+(\\.\\d+(\\.\\d+)?)?";
			   jar="lib/resin.jar";
			   subn="com/caucho/Version.class";
	    } );
   },
   
   { name="proftpd";
     type="elf";
     alias=["proftpd"];
     conf=[""];
     cnfarg="";
     sigs=(
       { patn="Version: \\d{1,2}\.\\d{1,2}\.\\d{1,2}rc\\d \\(devel\\)";
         offs=9;
         mstr="";
         class="rodata";
       });
   },

   { name="php-cgi";
     type="elf";
     alias=["php-cgi"];
     conf=[""];
     cnfarg="";
     sigs=(
       { patn="/root/soft/php-\\d{1,2}\.\\d{1,2}\.\\d{1,2}";
         offs=15;
         mstr="";
         class="rodata";
       });
   },

   { name="php-fpm";
     type="elf";
     alias=["php-fpm"];
     conf=["etc/php.ini","bin/php.ini","lib/php.ini","./php.ini"];
     cnfarg="-c";
     sigs=(
       { patn="/root/soft/php-\\d{1,2}\.\\d{1,2}\.\\d{1,2}";
         offs=15;
         mstr="";
         class="rodata";
       });
   },

   { name="java";
     type="elf";
     alias=["java"];
     conf=[""];
     cnfarg="";
     sigs=(
       { patn="(\\d+\\.){2}\\d+([_-]\\w+){1,}";
         offs=0;
         mstr="";
         class="rodata";
       });
   }
);
