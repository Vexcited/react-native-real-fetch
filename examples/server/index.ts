import { Elysia, t } from "elysia";

new Elysia()
  .post(
    "/",
    ({ body }) => {
      return {
        ok: true,
        data: body,
      };
    },
    {
      body: t.Object({
        hello: t.String(),
        falsy: t.Boolean(),
      }),
    }
  )
  .listen(6000);
