# Vulkan Notes
This document is a place for me to keep track of my "I don't get this" moments and what cleared the confusion.

## Why is the render pass needed in the creation of pipelines and frame buffers?
If not for this requirement, i would be able to just pass the vertex shader code, fragment shader code, descriptor set layouts and graphics context to the shader creation function, and only save the pipeline and pipeline layout handles in the shader helper struct.

It does not make sense for me because why should the shader be tied to a specific render pass?
Even in the render code we first start the render pass, giving it some values including the frame buffer:
```zig
command_buffer_proxy.beginRenderPass(&vk.RenderPassBeginInfo{
    .render_pass = self.render_pass,
    .render_area = render_area,
    .framebuffer = framebuffer,
    .clear_value_count = clear_values.len,
    .p_clear_values = @ptrCast(&clear_values),
}, .@"inline");
```
But then, we call a different method to bind the graphics pipeline:
```zig
command_buffer_proxy.bindPipeline(.graphics, shader.pipeline);
```

Are we now forced to bind this pipeline only to this render pass? That would not make sense to me.

### Answer

Turns out that when passing a render pass during a graphics pipeline creation, the resulting graphics pipeline is not "bound" to the passed render pass but instead made compatible with it, and any other similar render pass. This means that the graphics pipeline can be used with different render passes, as long as they are "similar" to each other (i haven't figured out in what way they have to be similar).

When it comes to frame buffers, it might be a matter of optimisation. 
Quoting @jackohound:
> Selecting the optimal tiling strategy and compiling the renderpass/subpasses for the selected tiling strategy can be quite expensive. For some implementations (e.g., Adreno) the first opportunity to perform this work is at createFramebuffer time, where the essential information is available.

And @ratchetfreak:
> One of the design constraints of vulkan is that as much as possible must be precomputed and give client code the opportunity to force that precomputation on its own terms to avoid a "warm up hitch" in the main render code like you'll find in opengl.

Source:
- https://www.reddit.com/r/vulkan/comments/kjzkqi/what_is_the_reason_we_reference_render_pass_in/
- https://github.com/KhronosGroup/Vulkan-Docs/issues/1147#issuecomment-572580007
