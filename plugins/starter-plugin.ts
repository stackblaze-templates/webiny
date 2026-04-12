/**
 * Webiny Plugin Scaffold
 *
 * Webiny uses a plugin-based architecture. Plugins are functions that
 * extend the system. Place plugins in this directory and register them
 * in your Webiny app configuration.
 *
 * See: https://www.webiny.com/docs/core-development-concepts/plugins
 */
import { ContextPlugin } from "@webiny/api";

export const starterPlugin = new ContextPlugin(async (context) => {
  console.log("Starter plugin loaded!");

  // Example: Add a custom GraphQL field resolver
  // context.plugins.register({
  //   type: "graphql-schema",
  //   schema: { typeDefs: `extend type Query { hello: String }`, resolvers: { Query: { hello: () => "Hello from plugin!" } } }
  // });
});