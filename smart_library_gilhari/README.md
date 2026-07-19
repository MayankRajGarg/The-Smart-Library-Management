# Smart Library System

Imagine a library that keeps track of every book, every member, every staff person, and every time a book is borrowed or returned - all automatically, without anyone having to write the software to manage it by hand.

That's what this project does. It's a working example of a **Smart Library Management System** that can:

- Keep a catalog of books
- Keep a list of members
- Keep a list of staff
- Record every time a book is issued or returned, and who was involved

The neat part: you don't have to build the database or write the code that saves, updates, or deletes this information. It's all generated for you automatically, based on a simple description of what a "Library," "Book," "Member," "Staff," and "Transaction" look like.

This makes the project a great starting point if you want to see how a real-world system — with people, items, and activity all connected — can be set up quickly and run as a self-contained service.

### Object Model
---
This project implements a Smart Library Management System with a hierarchical object model consisting of libraries, books, members, staff, and library transactions.

The model demonstrates:

- **One-to-many BYVALUE relationships** between a Library and its Books, Members, Staff, and Library Transactions.
- **BYREFERENCE relationships** from each Library Transaction to the corresponding Book, Member, and Staff entities.
- Automatic generation of the relational database schema using JDX.
- Automatic exposure of REST APIs (POST, GET, PUT, PATCH, DELETE) by the Gilhari framework.
- PostgreSQL integration using the PostgreSQL JDBC driver.
- JSON persistence with nested object graphs and relationship management.

The application is packaged as a Docker image built on the **softwaretree/gilhari** base image, allowing it to run as a RESTful microservice for managing library data without writing any server-side CRUD logic.

## Model Overview

This example showcases a Smart Library Management System consisting of five object types: **Library**, **Book**, **Member**, **Staff**, and **LibraryTransaction**.

**Object Model Overview:**
- **Library**: Root object containing collections of books, members, staff, and library transactions.
- **Book**: Represents a library book with its unique identifier and title.
- **Member**: Represents a registered library member.
- **Staff**: Represents library staff responsible for managing transactions.
- **LibraryTransaction**: Represents a book issue or return transaction, linking a book, member, and staff member.
- **Attributes:**
  - **Library**: libraryId (int), name (string), books (array of Book), members (array of Member), staff (array of Staff), librarytransactions (array of LibraryTransaction)
  - **Book**: bookId (int), libraryId (int), title (string)
  - **Member**: memberId (int), libraryId (int), name (string)
  - **Staff**: staffId (int), libraryId (int), name (string)
  - **LibraryTransaction**: transactionId (int), libraryId (int), bookId (int), memberId (int), staffId (int), type (string), date (string)
- **Database Tables**: Library, Book, Member, Staff, LibraryTransaction

### What Makes This Different?
---
This example demonstrates a combination of **BYVALUE (containment)** and **BYREFERENCE (association)** relationships.

**Relationship Patterns:**
- **One-to-many BYVALUE**:
  - A **Library** contains multiple **Books**.
  - A **Library** contains multiple **Members**.
  - A **Library** contains multiple **Staff**.
  - A **Library** contains multiple **LibraryTransactions**.
- **BYREFERENCE relationships**:
  - Each **LibraryTransaction** references a **Book**.
  - Each **LibraryTransaction** references a **Member**.
  - Each **LibraryTransaction** references a **Staff**.

**BYVALUE Semantics:**
- Books, Members, Staff, and LibraryTransactions are contained within a Library.
- These child objects are created, retrieved, updated, and deleted through their parent Library.
- Deleting a Library removes its contained objects.

**Transaction Tracking:**
- Each LibraryTransaction records whether a book was **ISSUE**d or **RETURN**ed.
- Transactions maintain references to the associated Book, Member, and Staff, allowing complete borrowing history to be maintained.

**Configuration:**
See `config/smart_library_system.jdx` for the JDX mapping that configures BYVALUE and BYREFERENCE relationships, PostgreSQL persistence, and automatic REST API generation for the Smart Library Management System.

## How It Works

This project is built using **Gilhari**, a Docker-compatible microservice framework that provides RESTful Object-Relational Mapping (ORM) functionality for JSON objects with relational databases.

Gilhari automatically exposes REST APIs for CRUD operations and manages the underlying PostgreSQL schema through JDX mappings — **without requiring manual REST API or SQL implementation**.

### An Example Object
```json
{
  "entity": {
    "libraryId": 1,
    "name": "Central Library",
    "books": [
      {
        "bookId": 101,
        "libraryId": 1,
        "title": "Clean Code"
      }
    ],
    "members": [
      {
        "memberId": 201,
        "libraryId": 1,
        "name": "Alice"
      }
    ],
    "staff": [
      {
        "staffId": 301,
        "libraryId": 1,
        "name": "Admin"
      }
    ],
    "librarytransactions": [
      {
        "transactionId": 401,
        "libraryId": 1,
        "bookId": 101,
        "memberId": 201,
        "staffId": 301,
        "type": "ISSUE",
        "date": "2026-07-11"
      }
    ]
  }
}
```

## Project Structure

```
smart_library_system/
├── src/                           # Container domain model classes
│   └── com/softwaretree/...       # Library.java, Book.java, Member.java, Staff.java, LibraryTransaction.java
├── config/                        # Configuration files
│   ├── smart_library_system.jdx   # ORM specification with BYVALUE relationships
│   ├── classnames_map_example.js
│   └── postgresql Driver
├── bin/                           # Compiled .class files
├── Dockerfile                     # Docker image definition
├── gilhari_service.config         # Service configuration
├── compile.cmd                    # Compilation scripts
├── build.cmd                      # Docker build scripts
├── run_docker_app.cmd             # Docker run scripts
├── libraryObjectExample.json      # An Example JSON object for the model
├── curlCommands.cmd               # API testing scripts
└── curlCommandsPopulate.cmd       # Sample data population scripts
```

## Source Code
The `src` directory contains the declarations of the underlying shell (container) classes that are used to define the object-relational mapping (ORM) specification for the corresponding conceptual domain-specific JSON object model classes:

- **Classes**: Simple shell (container) classes (.java files) corresponding to the domain-specific JSON object model classes of related entities (Container domain model classes)
- **JDX_JSONObject**: Base class of the container domain model classes for handling persistence of domain-specific JSON objects
- **Container domain model classes**: Only need to define two constructors, with most processing handled by the JDX_JSONObject superclass

**Note:** Gilhari does not require any explicit programmatic definitions (e.g., ES6 style JavaScript classes) for domain-specific JSON object model classes. It handles the data of domain-specific JSON objects using instances of the container domain model classes and the ORM specification.

## Configurations

A declarative ORM specification for the domain-specific JSON object model classes and their attributes is defined in `config/smart_library_system.jdx` using the container domain model classes. This file defines the mappings between JSON objects and database tables, **including BYVALUE relationship configurations**.

**Key points:**
- Update the database URL and JDBC driver in this file according to your setup
- See `JDX_DATABASE_JDBC_DRIVER_Specification_Guide` (.md or .html) for guides on configuring different databases
- The container domain model classes corresponding to the conceptual domain-specific JSON object model classes are defined as subclasses of the JDX_JSONObject class
- Appropriate mappings for the domain-specific JSON object model classes are defined in the ORM specification file using the corresponding container domain model classes
- **BYVALUE relationship configuration** establishes containment semantics where child objects are owned by their parent

For comprehensive details on defining and using container classes and the ORM specification for JSON object models, refer to the **"Persisting JSON Objects"** section in the JDX User Manual.

### BYVALUE Relationship Configuration

The key to this example is in the ORM specification file (`config/smart_library_system.jdx`), where relationships are configured using BYVALUE semantics.

### Docker Configuration

The `Dockerfile` builds a RESTful Gilhari microservice using:
- Base Gilhari image (softwaretree/gilhari)
- Compiled domain model (.class) files
- Configuration files including the ORM specification and a JDBC driver

### Service Configuration

The `gilhari_service.config` file specifies runtime parameters for the RESTful Gilhari microservice:

```json
{
  "gilhari_microservice_name": "smart_library_system",
  "jdx_orm_spec_file": "./config/smart_library_system.jdx",
  "jdbc_driver_path": "./config/postgresql-42.7.11.jar",
  "jdx_debug_level": 5,
  "jdx_force_create_schema": "true",
  "jdx_persistent_classes_location": "./bin",
  "classnames_map_file": "config/classnames_map_example.js",
  "gilhari_rest_server_port": 8081
}
```

#### Service Configuration Parameters

| Parameter | Description | Default |
|-----------|-------------|---------|
| `gilhari_microservice_name` | Optional name to identify this Gilhari microservice. The name is logged on console during start up | - |
| `jdx_orm_spec_file` | Location of the ORM specification file containing mapping for persistent classes | - |
| `jdbc_driver_path` | Path to the JDBC driver (.jar) file. SQLite driver included by default | - |
| `jdx_debug_level` | Debug output level (0-5). 0 = most verbose, 5 = minimal. Level 3 outputs all SQL statements | 5 |
| `jdx_force_create_schema` | Whether to recreate database schema on each run. `true` = useful for development, `false` = create only once | false |
| `jdx_persistent_classes_location` | Root location for compiled persistent (Container domain model) classes. Can be a directory (e.g., ./bin) or a JAR file path. Used as a Java CLASSPATH  | - |
| `classnames_map_file` | Optional JSON file that can map names of container domain model classes to (simpler) object class (type) names (e.g., by omitting a package name) to simplify REST URL| - |
| `gilhari_rest_server_port` | Port number for the RESTful service. This port number may be mapped to different port number (e.g., 80) by a docker run command. | 8081 |


## Build Files
- `compile.cmd` / `compile.sh`: Compiles the container domain model classes
- `sources.txt`: Lists the names of the container domain model class source (.java) files for compilation
- `build.cmd` / `build.sh`: Creates the Gilhari Docker image (smart_library_system) using the local Dockerfile

**Note**: Compilation targets JDK version 1.8, which is compatible with the current Gilhari version.

## Quick Start

### For Quick Evaluation (No SDK Required)
If you just want to see this example in action without modifications:

1. **Install Docker**
2. **Compile, Build and run**

### For Development and Customization
If you want to modify the object model or create your own Gilhari microservices:

1. **Gilhari SDK**: Download and install from [https://softwaretree.com](https://softwaretree.com)
2. **JX_HOME environment variable**: Set to the root directory of your Gilhari SDK installation
3. **Java Development Kit (JDK 1.8+)** for compilation
4. **Docker** installed on your system

**Note:** The Gilhari SDK contains necessary libraries (JARs) and base classes required for compiling container domain model classes. While pre-compiled `.class` files are included in this repository for immediate use, you'll need the SDK to make any modifications to the object model or to create your own Gilhari microservices.

## Build and Run

### Option 1: Quick Run (Using Pre-compiled Classes)

**Skip compilation** and go straight to Docker:

```bash
# Windows
build.cmd
run_docker_app.cmd

# Linux/Mac
./build.sh
./run_docker_app.sh
```

### Option 2: Compile and Run (For Modifications)

**If you've made changes to the source code:**

1. **Ensure JX_HOME is set** to your Gilhari SDK installation directory

2. **Compile the classes**:
   ```bash
   # Windows
   compile.cmd
   
   # Linux/Mac
   ./compile.sh
   ```

3. **Build and run the Docker container**:
   ```bash
   # Windows
   build.cmd
   run_docker_app.cmd
   
   # Linux/Mac
   ./build.sh
   ./run_docker_app.sh
   ```

## REST API Usage

Once running, access the Gilhari microservice at:

```
http://localhost:<port>/gilhari/v1/:className
```

### Supported HTTP Methods

| Method | Purpose | Example |
|--------|---------|---------|
| GET | Retrieve objects | `GET /gilhari/v1/Library` |
| POST | Create objects | `POST /gilhari/v1/Library` |
| PUT | Update objects | `PUT /gilhari/v1/Library` |
| PATCH | Partial update | `PATCH /gilhari/v1/Library` |
| DELETE | Delete objects | `DELETE /gilhari/v1/Library` |


### Testing the API

**Comprehensive test scripts:**

1. **curlCommandsPopulate.cmd** - Complete demonstration of relationship operations

   Demonstrates:
   - Health check endpoint
   - Creating objects with contained objects
   - Deep and shallow queries
   - Path expressions for filtering
   - Cascading deletes (BYVALUE behavior)
   - Test Multiple operations and Pooputale with Sample Data


Run the scripts to generate a `curl.log` file with all responses:
```bash
# Windows
curlCommandsPopulate.cmd

# Custom port
curlCommandsPopulate.sh 8899
```

The scripts will create a `curl.log` file with all the API responses, demonstrating relationship management and advanced query capabilities including path expressions, projections, and selective following.

**Note:** The **`operationDetails`** parameter in a query allows you to fine-tune query operations with operational directives similar to **GraphQL** capabilities. It accepts a JSON array containing one or more operation directives that refine the shape and scope of returned objects. For more details, see `operationDetails_doc.md`.

**Other options:**
- **Postman**: Import the endpoints for interactive testing
- **Browser**: Access GET endpoints directly
- **Any REST Client**: Standard HTTP methods work with any REST client
- **ORMCP Server** (optional): Use ORMCP Server tools for AI-powered interactions

## Using with ORMCP Server (Optional)

This Gilhari microservice can be used with the ORMCP Server for AI-powered database interactions:

1. **Start this Gilhari microservice** (as shown in Quick Start)
2. **Configure ORMCP Server** to connect to this microservice endpoint
3. **Use ORMCP tools** to query and manipulate the objects through natural language

The ORMCP Server will automatically handle the relationship navigation and understand the BYVALUE containment semantics.

For more information on ORMCP Server:
- **ORMCP Documentation**: [https://github.com/softwaretree/ormcp-docs](https://github.com/softwaretree/ormcp-docs)
- **ORMCP/Gilhari Examples**: [https://github.com/softwaretree/ormcp-docs#examples](https://github.com/softwaretree/ormcp-docs#examples)
- **Product Website**: [https://www.softwaretree.com/products/ormcp/](https://www.softwaretree.com/products/ormcp/)

## Development Tools

### Docker Container Access
Shell into a running container:
```bash
# Find container ID
docker ps

# Access container
docker exec -it <container-id> bash
```

### View Logs
```bash
docker logs <container-id>
```

### Stop Container
```bash
docker stop <container-id>
```

## Additional Resources

- **JDX User Manual**: "Persisting JSON Objects" section for detailed ORM specification documentation
- **Gilhari SDK Documentation**: The SDK available for download at [https://softwaretree.com](https://softwaretree.com)
- **ORMCP Documentation**: [https://github.com/softwaretree/ormcp-docs](https://github.com/softwaretree/ormcp-docs)
- **Database Configuration Guide**: See `JDX_DATABASE_JDBC_DRIVER_Specification_Guide.md`
- **operationDetails Documentation**: See `operationDetails_doc.md` for GraphQL-like query capabilities

## Platform Notes

Script files are provided for Windows (`.cmd`). 

## Troubleshooting

### Common Issues

**Problem**: Docker image build fails
- **Solution**: Ensure the base Gilhari image is pulled: `docker pull softwaretree/gilhari`

**Problem**: Compilation errors
- **Solution**: Verify JDK 1.8+ is installed and JX_HOME environment variable is set correctly

**Problem**: Port 80 already in use
- **Solution**: Modify `run_docker_app` script to use a different port (e.g., `-p 8080:8081`)

**Problem**: Database connection errors
- **Solution**: Check `config/smart_library_system.jdx` for correct database URL and JDBC driver path

**Problem**: Child objects (B, C) not deleted when parent (A) is deleted
- **Solution**: This example uses BYVALUE semantics - child objects should be deleted. Verify the ORM specification has BYVALUE configured for the relationships

**Problem**: Path expressions not working (e.g., `jdxObject.aB.bInt>100`)
- **Solution**: Ensure the path expression syntax is correct and properly URL-encoded. The `jdxObject` prefix is required for navigating relationships

**Problem**: Projections or follow operations not working
- **Solution**: Ensure the `operationDetails` parameter is properly URL-encoded. Use `--data-urlencode` with curl

## Support

For issues or questions:
- **ORMCP Documentation & Issues**: [https://github.com/softwaretree/ormcp-docs/issues](https://github.com/softwaretree/ormcp-docs/issues)
- **Gilhari SDK**: Contact support at [gilhari_support@softwaretree.com](mailto:gilhari_support@softwaretree.com)

## License

This example code is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

**Important:** This license applies ONLY to the example code in this repository. The Gilhari software (including the softwaretree/gilhari Docker image and Gilhari SDK) and the embedded JDX ORM software are proprietary products owned by Software Tree.

The Gilhari Docker image includes an evaluation license for testing purposes. For production use or licensing beyond the evaluation period, please visit [https://www.softwaretree.com](https://www.softwaretree.com) or contact [gilhari_support@softwaretree.com](mailto:gilhari_support@softwaretree.com).

---

**Ready to try it?** Start with the [Quick Start](#quick-start) section above!