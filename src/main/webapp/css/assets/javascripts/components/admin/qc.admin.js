/* 说明：如果使用url方式引入页面，自己页面的变量，必须在qc下添加命名空间
 * 例： 添加页面 planTreeYear.jsp
 *      命名空间为 qc.planTreeYear (命名空间可以自定义，要求不与其他页面命名空间重复即可)
 *      变量为 qc.planTreeYear.dgTree  定义datagrid
 *          或 qc.planTreeYear.comboPerson  定义combobox
 */

// 定义命名空间
Namespace.register("qc.combotree");
Namespace.register("qc.combobox");
Namespace.register("qc.datagrid");
Namespace.register("qc.treegrid");
Namespace.register("qc.dialog");
Namespace.register("qc.tree");
Namespace.register("qc.form");
Namespace.register("qc.tabs");
