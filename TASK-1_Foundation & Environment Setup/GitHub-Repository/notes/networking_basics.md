OSI Model Layers & Functions

The Open Systems Interconnection (OSI) model is a conceptual framework that explains how data flows from one computer to another. It's a way to standardize communication and make it easier to troubleshoot networking issues.
The model has seven layers, each with a specific function:

Layer 1 (Physical): Deals with the physical transmission of data bits over a medium, such as cables or Wi-Fi.

Layer 2 (Data Link): Manages data frames and uses MAC addresses to handle the flow of data within a local network.

Layer 3 (Network): Handles routing and addressing across multiple networks, primarily using IP addresses. It packages data into smaller packets and decides the best path for them to travel.

Layer 4 (Transport): Ensures that data packets arrive in the correct order, without errors or losses. It uses protocols like TCP and UDP to manage data segments and provide reliable data transfer.

Layer 5 (Session): Manages the communication session between two applications, including the beginning and ending of a connection.

Layer 6 (Presentation): Translates and formats data so it can be understood by the receiving application. It handles things like encryption and data compression.

Layer 7 (Application): The layer closest to the end user. It provides services for applications like web browsers and email clients to communicate.

TCP/IP Protocol Suite

The TCP/IP model is a more practical and widely used model than the OSI model. It's a set of protocols that defines how data is addressed, transmitted, and received on the internet.

TCP (Transmission Control Protocol): A reliable, connection-oriented protocol that guarantees data will be delivered in the correct order. It breaks data into packets on the sender side and reassembles them at the destination, ensuring no data is lost or duplicated.

IP (Internet Protocol): A protocol that assigns a unique IP address to each device on the network. IP is responsible for routing data packets from a source to a destination.

DNS & HTTP/HTTPS

DNS (Domain Name System): The "phonebook of the internet." Humans use domain names (like google.com), but computers use IP addresses. DNS translates human-readable domain names into machine-readable IP addresses. When you type a URL, your computer sends a request to a DNS server to find the correct IP address for that website.

HTTP (Hypertext Transfer Protocol): The core protocol for data communication on the World Wide Web. It's the language that allows your web browser to request web pages from a server.

HTTPS (HTTP Secure): The secure version of HTTP. It uses SSL/TLS to encrypt all communication between your browser and a web server. This protects sensitive information like passwords and credit card numbers from being intercepted. The URL prefix for HTTP is http://, while for HTTPS it is https://.

IP Addressing, Subnetting, and NAT

IP Addressing: Every device on a network needs a unique IP address to communicate. These addresses are used by routers to deliver data to the right device.

Subnetting: The process of dividing a large network into smaller, more manageable sub-networks, or "subnets". This helps to prevent IP address exhaustion and improves network performance and security by reducing traffic and isolating critical systems.

NAT (Network Address Translation): A method that allows multiple devices on a private network (like your home network) to share a single public IP address when they communicate with the internet. This is crucial for conserving the number of public IP addresses and adds a layer of security.