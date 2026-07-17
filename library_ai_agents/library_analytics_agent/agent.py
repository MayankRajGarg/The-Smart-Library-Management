from google.adk.agents import Agent
from google.adk.tools.mcp_tool import McpToolset
from google.adk.tools.mcp_tool.mcp_session_manager import StreamableHTTPConnectionParams

root_agent = Agent(
    model="gemini-flash-latest",
    name="library_analytics_agent",
    instruction="""
    You are a Library Analytics Agent. Use ORMCP tools only for reading data.
    Generate reports, trends and statistics. Never modify the database.
    """,
    tools=[
        McpToolset(
            connection_params=StreamableHTTPConnectionParams(
                url="http://127.0.0.1:8080/mcp/",
            ),
        )
    ],
)