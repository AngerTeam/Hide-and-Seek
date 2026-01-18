Shader "Unlit/Clouds" {
Properties {
 _Alpha ("Alpha", Range(0.000000,1.000000)) = 0.500000
 _Color ("Main Color", Color) = (1.000000,1.000000,1.000000,0.000000)
}
SubShader { 
 LOD 100
 Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
 Pass {
  Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
  ZWrite Off
  Blend SrcAlpha OneMinusSrcAlpha
  GpuProgramID 49255
Program "vp" {
SubProgram "gles hw_tier01 " {

					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					uniform highp mat4 glstate_matrix_mvp;
					void main ()
					{
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp float _Alpha;
					uniform highp vec4 _Color;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  highp vec4 tmpvar_2;
					  tmpvar_2.xyz = _Color.xyz;
					  tmpvar_2.w = _Alpha;
					  tmpvar_1 = tmpvar_2;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif
}
SubProgram "gles hw_tier02 " {

					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					uniform highp mat4 glstate_matrix_mvp;
					void main ()
					{
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp float _Alpha;
					uniform highp vec4 _Color;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  highp vec4 tmpvar_2;
					  tmpvar_2.xyz = _Color.xyz;
					  tmpvar_2.w = _Alpha;
					  tmpvar_1 = tmpvar_2;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif
}
SubProgram "gles hw_tier03 " {

					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					uniform highp mat4 glstate_matrix_mvp;
					void main ()
					{
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp float _Alpha;
					uniform highp vec4 _Color;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  highp vec4 tmpvar_2;
					  tmpvar_2.xyz = _Color.xyz;
					  tmpvar_2.w = _Alpha;
					  tmpvar_1 = tmpvar_2;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif
}
SubProgram "gles3 hw_tier01 " {

					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					in highp vec4 in_POSITION0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	float _Alpha;
					uniform 	vec4 _Color;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0.xyz = _Color.xyz;
					    u_xlat0.w = _Alpha;
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif
}
SubProgram "gles3 hw_tier02 " {

					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					in highp vec4 in_POSITION0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	float _Alpha;
					uniform 	vec4 _Color;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0.xyz = _Color.xyz;
					    u_xlat0.w = _Alpha;
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif
}
SubProgram "gles3 hw_tier03 " {

					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					in highp vec4 in_POSITION0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	float _Alpha;
					uniform 	vec4 _Color;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0.xyz = _Color.xyz;
					    u_xlat0.w = _Alpha;
					    SV_Target0 = u_xlat0;
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
}