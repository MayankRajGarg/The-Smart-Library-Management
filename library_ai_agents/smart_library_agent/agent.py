from google.adk.agents import Agent
from google.adk.tools.mcp_tool import McpToolset
from google.adk.tools.mcp_tool.mcp_session_manager import StreamableHTTPConnectionParams

root_agent = Agent(
    model="gemini-flash-latest",
    name="smart_library_agent",
    instruction="""
    You are a Smart Library assistant.Use the ORMCP MCP tools whenever you need to access
    books, members, staff, libraries, or transactions.
    Never make up data.
    """,
    tools=[
        McpToolset(
            connection_params=StreamableHTTPConnectionParams(
                url="http://127.0.0.1:8080/mcp/",
            ),
        )
    ],
)