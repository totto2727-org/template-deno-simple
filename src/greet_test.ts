import { strictEqual } from "node:assert";
import { greet } from "./greet.ts";

Deno.test("greets the world when no name is supplied", () => {
  strictEqual(greet(), "Hello, world!");
});

Deno.test("greets a supplied name", () => {
  strictEqual(greet("TypeScript"), "Hello, TypeScript!");
});

Deno.test("preserves an empty name", () => {
  strictEqual(greet(""), "Hello, !");
});
