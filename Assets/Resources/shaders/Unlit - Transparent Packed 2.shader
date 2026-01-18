Shader "Hidden/Unlit/Transparent Packed 2" {
Properties {
 _MainTex ("Base (RGB), Alpha (A)", 2D) = "black" { }
}
SubShader { 
 LOD 200
 Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
 Pass {
  Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
  ZWrite Off
  Cull Off
  Blend SrcAlpha OneMinusSrcAlpha
  ColorMask RGB
  Offset -1.000000, -1.000000
  GpuProgramID 263
Program "vp" {
SubProgram "gles hw_tier01 " {

					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp vec4 _ClipRange0;
					uniform highp vec4 _ClipRange1;
					uniform highp vec4 _ClipArgs1;
					highp vec4 tmpvar_1;
					varying mediump vec4 xlv_COLOR;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  tmpvar_1.xy = ((_glesVertex.xy * _ClipRange0.zw) + _ClipRange0.xy);
					  highp vec2 ret_2;
					  ret_2.x = ((_glesVertex.x * _ClipArgs1.w) - (_glesVertex.y * _ClipArgs1.z));
					  ret_2.y = ((_glesVertex.x * _ClipArgs1.z) + (_glesVertex.y * _ClipArgs1.w));
					  tmpvar_1.zw = ((ret_2 * _ClipRange1.zw) + _ClipRange1.xy);
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_COLOR = _glesColor;
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = tmpvar_1;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					uniform highp vec4 _ClipArgs0;
					uniform highp vec4 _ClipArgs1;
					varying mediump vec4 xlv_COLOR;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  highp vec2 factor_1;
					  mediump vec4 col_2;
					  mediump vec4 mask_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
					  mask_3 = tmpvar_4;
					  mediump vec4 tmpvar_5;
					  tmpvar_5 = clamp (ceil((xlv_COLOR - 0.5)), 0.0, 1.0);
					  mediump vec4 tmpvar_6;
					  tmpvar_6 = clamp (((
					    (tmpvar_5 * 0.51)
					   - xlv_COLOR) / -0.49), 0.0, 1.0);
					  col_2.xyz = tmpvar_6.xyz;
					  highp vec2 tmpvar_7;
					  tmpvar_7 = ((vec2(1.0, 1.0) - abs(xlv_TEXCOORD1.xy)) * _ClipArgs0.xy);
					  factor_1 = ((vec2(1.0, 1.0) - abs(xlv_TEXCOORD1.zw)) * _ClipArgs1.xy);
					  mask_3 = (mask_3 * tmpvar_5);
					  highp float tmpvar_8;
					  tmpvar_8 = clamp (min (min (tmpvar_7.x, tmpvar_7.y), min (factor_1.x, factor_1.y)), 0.0, 1.0);
					  col_2.w = (tmpvar_6.w * tmpvar_8);
					  col_2.w = (col_2.w * ((mask_3.x + mask_3.y) + (mask_3.z + mask_3.w)));
					  gl_FragData[0] = col_2;
					}
					
					
					#endif
}
SubProgram "gles hw_tier02 " {

					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp vec4 _ClipRange0;
					uniform highp vec4 _ClipRange1;
					uniform highp vec4 _ClipArgs1;
					highp vec4 tmpvar_1;
					varying mediump vec4 xlv_COLOR;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  tmpvar_1.xy = ((_glesVertex.xy * _ClipRange0.zw) + _ClipRange0.xy);
					  highp vec2 ret_2;
					  ret_2.x = ((_glesVertex.x * _ClipArgs1.w) - (_glesVertex.y * _ClipArgs1.z));
					  ret_2.y = ((_glesVertex.x * _ClipArgs1.z) + (_glesVertex.y * _ClipArgs1.w));
					  tmpvar_1.zw = ((ret_2 * _ClipRange1.zw) + _ClipRange1.xy);
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_COLOR = _glesColor;
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = tmpvar_1;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					uniform highp vec4 _ClipArgs0;
					uniform highp vec4 _ClipArgs1;
					varying mediump vec4 xlv_COLOR;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  highp vec2 factor_1;
					  mediump vec4 col_2;
					  mediump vec4 mask_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
					  mask_3 = tmpvar_4;
					  mediump vec4 tmpvar_5;
					  tmpvar_5 = clamp (ceil((xlv_COLOR - 0.5)), 0.0, 1.0);
					  mediump vec4 tmpvar_6;
					  tmpvar_6 = clamp (((
					    (tmpvar_5 * 0.51)
					   - xlv_COLOR) / -0.49), 0.0, 1.0);
					  col_2.xyz = tmpvar_6.xyz;
					  highp vec2 tmpvar_7;
					  tmpvar_7 = ((vec2(1.0, 1.0) - abs(xlv_TEXCOORD1.xy)) * _ClipArgs0.xy);
					  factor_1 = ((vec2(1.0, 1.0) - abs(xlv_TEXCOORD1.zw)) * _ClipArgs1.xy);
					  mask_3 = (mask_3 * tmpvar_5);
					  highp float tmpvar_8;
					  tmpvar_8 = clamp (min (min (tmpvar_7.x, tmpvar_7.y), min (factor_1.x, factor_1.y)), 0.0, 1.0);
					  col_2.w = (tmpvar_6.w * tmpvar_8);
					  col_2.w = (col_2.w * ((mask_3.x + mask_3.y) + (mask_3.z + mask_3.w)));
					  gl_FragData[0] = col_2;
					}
					
					
					#endif
}
SubProgram "gles hw_tier03 " {

					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp vec4 _ClipRange0;
					uniform highp vec4 _ClipRange1;
					uniform highp vec4 _ClipArgs1;
					highp vec4 tmpvar_1;
					varying mediump vec4 xlv_COLOR;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  tmpvar_1.xy = ((_glesVertex.xy * _ClipRange0.zw) + _ClipRange0.xy);
					  highp vec2 ret_2;
					  ret_2.x = ((_glesVertex.x * _ClipArgs1.w) - (_glesVertex.y * _ClipArgs1.z));
					  ret_2.y = ((_glesVertex.x * _ClipArgs1.z) + (_glesVertex.y * _ClipArgs1.w));
					  tmpvar_1.zw = ((ret_2 * _ClipRange1.zw) + _ClipRange1.xy);
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_COLOR = _glesColor;
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = tmpvar_1;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					uniform highp vec4 _ClipArgs0;
					uniform highp vec4 _ClipArgs1;
					varying mediump vec4 xlv_COLOR;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  highp vec2 factor_1;
					  mediump vec4 col_2;
					  mediump vec4 mask_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
					  mask_3 = tmpvar_4;
					  mediump vec4 tmpvar_5;
					  tmpvar_5 = clamp (ceil((xlv_COLOR - 0.5)), 0.0, 1.0);
					  mediump vec4 tmpvar_6;
					  tmpvar_6 = clamp (((
					    (tmpvar_5 * 0.51)
					   - xlv_COLOR) / -0.49), 0.0, 1.0);
					  col_2.xyz = tmpvar_6.xyz;
					  highp vec2 tmpvar_7;
					  tmpvar_7 = ((vec2(1.0, 1.0) - abs(xlv_TEXCOORD1.xy)) * _ClipArgs0.xy);
					  factor_1 = ((vec2(1.0, 1.0) - abs(xlv_TEXCOORD1.zw)) * _ClipArgs1.xy);
					  mask_3 = (mask_3 * tmpvar_5);
					  highp float tmpvar_8;
					  tmpvar_8 = clamp (min (min (tmpvar_7.x, tmpvar_7.y), min (factor_1.x, factor_1.y)), 0.0, 1.0);
					  col_2.w = (tmpvar_6.w * tmpvar_8);
					  col_2.w = (col_2.w * ((mask_3.x + mask_3.y) + (mask_3.z + mask_3.w)));
					  gl_FragData[0] = col_2;
					}
					
					
					#endif
}
SubProgram "gles3 hw_tier01 " {

					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 _ClipRange0;
					uniform 	vec4 _ClipRange1;
					uniform 	vec4 _ClipArgs1;
					in highp vec4 in_POSITION0;
					in mediump vec4 in_COLOR0;
					in highp vec2 in_TEXCOORD0;
					out mediump vec4 vs_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec2 u_xlat2;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    vs_COLOR0 = in_COLOR0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = in_POSITION0.y * _ClipArgs1.z;
					    u_xlat2.x = in_POSITION0.x * _ClipArgs1.w + (-u_xlat0.x);
					    u_xlat2.y = dot(in_POSITION0.xy, _ClipArgs1.zw);
					    vs_TEXCOORD1.zw = u_xlat2.xy * _ClipRange1.zw + _ClipRange1.xy;
					    vs_TEXCOORD1.xy = in_POSITION0.xy * _ClipRange0.zw + _ClipRange0.xy;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec4 _ClipArgs0;
					uniform 	vec4 _ClipArgs1;
					uniform lowp sampler2D _MainTex;
					in mediump vec4 vs_COLOR0;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump vec4 u_xlat16_0;
					vec4 u_xlat1;
					lowp vec4 u_xlat10_1;
					mediump vec2 u_xlat16_2;
					void main()
					{
					    u_xlat16_0 = vs_COLOR0 + vec4(-0.5, -0.5, -0.5, -0.5);
					    u_xlat16_0 = ceil(u_xlat16_0);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
					#else
					    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
					#endif
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat16_2.xy = u_xlat16_0.xy * u_xlat10_1.xy;
					    u_xlat16_2.x = u_xlat16_2.y + u_xlat16_2.x;
					    u_xlat16_2.x = u_xlat10_1.z * u_xlat16_0.z + u_xlat16_2.x;
					    u_xlat16_2.x = u_xlat10_1.w * u_xlat16_0.w + u_xlat16_2.x;
					    u_xlat16_0 = u_xlat16_0 * vec4(0.50999999, 0.50999999, 0.50999999, 0.50999999) + (-vs_COLOR0);
					    u_xlat16_0 = u_xlat16_0 * vec4(-2.04081631, -2.04081631, -2.04081631, -2.04081631);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
					#else
					    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
					#endif
					    u_xlat1 = -abs(vs_TEXCOORD1) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat1.xy = u_xlat1.xy * _ClipArgs0.xy;
					    u_xlat1.zw = vec2(u_xlat1.z * _ClipArgs1.x, u_xlat1.w * _ClipArgs1.y);
					    u_xlat1.xz = min(u_xlat1.yw, u_xlat1.xz);
					    u_xlat1.x = min(u_xlat1.z, u_xlat1.x);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    u_xlat1.x = u_xlat16_0.w * u_xlat1.x;
					    SV_Target0.xyz = u_xlat16_0.xyz;
					    SV_Target0.w = u_xlat16_2.x * u_xlat1.x;
					    return;
					}
					#endif
}
SubProgram "gles3 hw_tier02 " {

					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 _ClipRange0;
					uniform 	vec4 _ClipRange1;
					uniform 	vec4 _ClipArgs1;
					in highp vec4 in_POSITION0;
					in mediump vec4 in_COLOR0;
					in highp vec2 in_TEXCOORD0;
					out mediump vec4 vs_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec2 u_xlat2;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    vs_COLOR0 = in_COLOR0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = in_POSITION0.y * _ClipArgs1.z;
					    u_xlat2.x = in_POSITION0.x * _ClipArgs1.w + (-u_xlat0.x);
					    u_xlat2.y = dot(in_POSITION0.xy, _ClipArgs1.zw);
					    vs_TEXCOORD1.zw = u_xlat2.xy * _ClipRange1.zw + _ClipRange1.xy;
					    vs_TEXCOORD1.xy = in_POSITION0.xy * _ClipRange0.zw + _ClipRange0.xy;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec4 _ClipArgs0;
					uniform 	vec4 _ClipArgs1;
					uniform lowp sampler2D _MainTex;
					in mediump vec4 vs_COLOR0;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump vec4 u_xlat16_0;
					vec4 u_xlat1;
					lowp vec4 u_xlat10_1;
					mediump vec2 u_xlat16_2;
					void main()
					{
					    u_xlat16_0 = vs_COLOR0 + vec4(-0.5, -0.5, -0.5, -0.5);
					    u_xlat16_0 = ceil(u_xlat16_0);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
					#else
					    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
					#endif
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat16_2.xy = u_xlat16_0.xy * u_xlat10_1.xy;
					    u_xlat16_2.x = u_xlat16_2.y + u_xlat16_2.x;
					    u_xlat16_2.x = u_xlat10_1.z * u_xlat16_0.z + u_xlat16_2.x;
					    u_xlat16_2.x = u_xlat10_1.w * u_xlat16_0.w + u_xlat16_2.x;
					    u_xlat16_0 = u_xlat16_0 * vec4(0.50999999, 0.50999999, 0.50999999, 0.50999999) + (-vs_COLOR0);
					    u_xlat16_0 = u_xlat16_0 * vec4(-2.04081631, -2.04081631, -2.04081631, -2.04081631);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
					#else
					    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
					#endif
					    u_xlat1 = -abs(vs_TEXCOORD1) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat1.xy = u_xlat1.xy * _ClipArgs0.xy;
					    u_xlat1.zw = vec2(u_xlat1.z * _ClipArgs1.x, u_xlat1.w * _ClipArgs1.y);
					    u_xlat1.xz = min(u_xlat1.yw, u_xlat1.xz);
					    u_xlat1.x = min(u_xlat1.z, u_xlat1.x);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    u_xlat1.x = u_xlat16_0.w * u_xlat1.x;
					    SV_Target0.xyz = u_xlat16_0.xyz;
					    SV_Target0.w = u_xlat16_2.x * u_xlat1.x;
					    return;
					}
					#endif
}
SubProgram "gles3 hw_tier03 " {

					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 _ClipRange0;
					uniform 	vec4 _ClipRange1;
					uniform 	vec4 _ClipArgs1;
					in highp vec4 in_POSITION0;
					in mediump vec4 in_COLOR0;
					in highp vec2 in_TEXCOORD0;
					out mediump vec4 vs_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec2 u_xlat2;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    vs_COLOR0 = in_COLOR0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = in_POSITION0.y * _ClipArgs1.z;
					    u_xlat2.x = in_POSITION0.x * _ClipArgs1.w + (-u_xlat0.x);
					    u_xlat2.y = dot(in_POSITION0.xy, _ClipArgs1.zw);
					    vs_TEXCOORD1.zw = u_xlat2.xy * _ClipRange1.zw + _ClipRange1.xy;
					    vs_TEXCOORD1.xy = in_POSITION0.xy * _ClipRange0.zw + _ClipRange0.xy;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec4 _ClipArgs0;
					uniform 	vec4 _ClipArgs1;
					uniform lowp sampler2D _MainTex;
					in mediump vec4 vs_COLOR0;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump vec4 u_xlat16_0;
					vec4 u_xlat1;
					lowp vec4 u_xlat10_1;
					mediump vec2 u_xlat16_2;
					void main()
					{
					    u_xlat16_0 = vs_COLOR0 + vec4(-0.5, -0.5, -0.5, -0.5);
					    u_xlat16_0 = ceil(u_xlat16_0);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
					#else
					    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
					#endif
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat16_2.xy = u_xlat16_0.xy * u_xlat10_1.xy;
					    u_xlat16_2.x = u_xlat16_2.y + u_xlat16_2.x;
					    u_xlat16_2.x = u_xlat10_1.z * u_xlat16_0.z + u_xlat16_2.x;
					    u_xlat16_2.x = u_xlat10_1.w * u_xlat16_0.w + u_xlat16_2.x;
					    u_xlat16_0 = u_xlat16_0 * vec4(0.50999999, 0.50999999, 0.50999999, 0.50999999) + (-vs_COLOR0);
					    u_xlat16_0 = u_xlat16_0 * vec4(-2.04081631, -2.04081631, -2.04081631, -2.04081631);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
					#else
					    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
					#endif
					    u_xlat1 = -abs(vs_TEXCOORD1) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat1.xy = u_xlat1.xy * _ClipArgs0.xy;
					    u_xlat1.zw = vec2(u_xlat1.z * _ClipArgs1.x, u_xlat1.w * _ClipArgs1.y);
					    u_xlat1.xz = min(u_xlat1.yw, u_xlat1.xz);
					    u_xlat1.x = min(u_xlat1.z, u_xlat1.x);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    u_xlat1.x = u_xlat16_0.w * u_xlat1.x;
					    SV_Target0.xyz = u_xlat16_0.xyz;
					    SV_Target0.w = u_xlat16_2.x * u_xlat1.x;
					    return;
					}
					#endif
}
}
Program "fp" {
SubProgram "gles hw_tier01 " {

}
SubProgram "gles hw_tier02 " {

}
SubProgram "gles hw_tier03 " {

}
SubProgram "gles3 hw_tier01 " {

}
SubProgram "gles3 hw_tier02 " {

}
SubProgram "gles3 hw_tier03 " {

}
}
 }
}
Fallback Off
}