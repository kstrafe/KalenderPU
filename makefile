SERVER_LIBS=".:commons-cli-1.2.jar:derby.jar"
SERVER_RUNPATH="bin:commons-cli-1.2.jar:derby.jar"
CLIENT_LIBS=".:commons-cli-1.2.jar:derby.jar:derbyclient.jar"
CLIENT_RUNPATH="bin:commons-cli-1.2.jar:derby.jar:derbyclient.jar"

setup:
	mkdir -p bin
	$(MAKE) dbreset

pserver:
	javac -classpath $(SERVER_LIBS) -d bin server/Server.java
	java -classpath $(SERVER_RUNPATH) server.Server --cli

vserver:
	javac -classpath $(SERVER_LIBS) -d bin server/Server.java
	java -classpath $(SERVER_RUNPATH) server.Server -v --cli

pclient:
	javac -classpath $(CLIENT_LIBS) -d bin client/Client.java
	java -classpath $(CLIENT_RUNPATH) client.Client --cli

vclient:
	javac -classpath $(CLIENT_LIBS) -d bin client/Client.java
	java -classpath $(CLIENT_RUNPATH) client.Client -v --cli

dbreset:
	rm -rf database
	java -classpath ".:derby.jar:derbytools.jar" -Djdbc.drivers=org.apache.derby.jdbc.EmbeddedDriver org.apache.derby.tools.ij < ijcommands.txt

clean:
	find . -name "*.class" | xargs rm

mclient:
	javac -d bin client/MinimalClient.java
	java -cp "bin" client.MinimalClient

mserver:
	javac -d bin server/MinimalServer.java
	java -cp "bin" server.MinimalServer

sclient:
	javac client/MinimalClient.java
	java -Djavax.net.ssl.trustStore=mySrvKeystore -Djavax.net.ssl.trustStorePassword=123456 client.MinimalClient

sserver:
	javac server/MinimalServer.java
	java -Djavax.net.ssl.keyStore=mySrvKeystore -Djavax.net.ssl.keyStorePassword=123456 server.MinimalServer

SERVER_LIBS_MAC=".:./commons-cli-1.2.jar:./derby.jar"
SERVER_RUNPATH_MAC=".:./bin:./commons-cli-1.2.jar:./derby.jar"
CLIENT_LIBS_MAC=".:commons-cli-1.2.jar:./derby.jar:./derbyclient.jar"
CLIENT_RUNPATH_MAC="bin:./commons-cli-1.2.jar:./derby.jar:./derbyclient.jar"

setup-mac:
	mkdir -p bin
	$(MAKE) dbreset-mac

pserver-mac:
	javac -classpath $(SERVER_LIBS_MAC) -d bin server/Server.java
	java -classpath $(SERVER_RUNPATH_MAC) .server.Server --cli

vserver-mac:
	javac -classpath $(SERVER_LIBS_MAC) -d bin server/Server.java
	java -classpath $(SERVER_RUNPATH_MAC) server.Server -v --cli

pclient-mac:
	javac -classpath $(CLIENT_LIBS_MAC) -d bin client/Client.java
	java -classpath $(CLIENT_RUNPATH_MAC) client.Client --cli

vclient-mac:
	javac -classpath $(CLIENT_LIBS_MAC) -d bin client/Client.java
	java -classpath $(CLIENT_RUNPATH_MAC) client.Client -v --cli

dbreset-mac:
	rm -rf database
	java -classpath ".:./derby.jar:./derbytools.jar" -Djdbc.drivers=org.apache.derby.jdbc.EmbeddedDriver org.apache.derby.tools.ij < ijcommands.txt

clean-mac:
	find . -name "*.class" | xargs rm

# INSERT INTO SystemUser (rank, fname, lname) VALUES (32, 'hi', 'there')