---
title: "Clustering EJB Timers on WildFly 9 with MySQL"
author: "Geoffrey Hayward"
date: 2016-02-04T11:00:00Z
categories:
- computing
tags:
- EJB
- MySQL
- WildFly
---
It turns out that getting EJB timer beans configured into a WildFly 9 domain cluster is quite easy. This post records how I got EJB timers working on a WildFly 9 cluster with a MySQL database as the timer bean's datasource. The domain profile I used was the 'ha' profile.

<!--more-->

Note this post deals with EJB timer beans and assumes you already have a WildFly 9 HA domain configured with a MySQL connection.

All I had to do was configure the "timer-service" element. Here is the configuration that worked for me:

```xml
<timer-service thread-pool-name="default" default-data-store="clustered-store">
   <data-stores>
       <database-data-store name="clustered-store" datasource-jndi-name="java:/MySqlDS" database="mysql" partition="timer"/>
   </data-stores>
</timer-service>
```

I have read another posts about [configuring a 'timer-service' with PostgreSQL](http://www.mastertheboss.com/jboss-server/wildfly-8/creating-clustered-ejb-3-timers) that talked about updating the SQL in the `timer-sql.properties` file. I found that MySQL just worked without the need to change the `timer-sql.properties` file. 

I created an example project to help validate the configuration. Here is the code from the example project:

**MessageManager.java**

```java
@Stateless
public class MessageManager {
    
    @PersistenceContext
    private EntityManager em;
    
    public Message save(Message m){
        return em.merge(m);
    }

}
```

**MessageTimer.java**

```java
@Stateless
public class MessageTimer {
    
    @Inject
    private MessageManager mm;
  
    @Schedule(hour = "*", minute = "*", second = "*/10", info ="Runs every 10 seconds", persistent = true)
    public void printDate() { 
        Message m = new Message();
        m.setServer(System.getProperty("server.name"));
        m.setTime(new java.util.Date().toString());
        mm.save(m);
    }
  
}
```

**Message.java**

```java
@Entity
@Table(name="message")
@XmlRootElement
@XmlAccessorType(XmlAccessType.FIELD)
public class Message implements Serializable {
    
    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    private long id;
    private String time;
    private String server;
    // with getters and setters 

}
```

With this code the message table should get exactly one entry, from a cluster bigger than a size of one, every ten seconds. The instance that runs should be seemingly random.

Note: you need to set 'server.name' for each server in the HA group via the server's 'System Properties'.
