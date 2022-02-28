exports.createPages = async ({ graphql, actions }) => {
  const { createPage } = actions
  
  // graphql による情報の取得
  const result = await graphql(
    `
    {
      allPageContentsCsv {
        group(field: cp_url) {
          group(field: ln_url) {
            fieldValue
          }
          fieldValue
        }
      }
    }
    `
  )
  
  if (result.errors) {
      reporter.panicOnBuild(`Error while running GraphQL query.`)
      return
  }
  
  // graphql のデータを使用してのページ定義
  const { group } = result.data.allPageContentsCsv
  group.forEach(cpurl => {
    cpurl.group.forEach(lnurl => {
      createPage({
        path: `/cafemap/${cpurl.fieldValue}/${lnurl.fieldValue}/`,
        component: require.resolve("./src/templates/linepage.js"),
        context: { lineUrl: lnurl.fieldValue }
      })
    })
  });
  
}
