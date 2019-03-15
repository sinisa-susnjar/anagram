#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <locale.h>
#include <wctype.h>
#include <wchar.h>
#include <glib.h>
void iterator(gpointer key, const GArray *array, gpointer user_data) {
	if (array->len <= 1) return;
	for (int i = 0; i < array->len; i++) wprintf(L"%ls ", g_array_index(array, wchar_t *, i));
	wprintf(L"\n");
}
gboolean g_wcstr_equal(const wchar_t *a, const wchar_t *b) { return wcscmp(a, b) == 0; }
guint g_wcstr_hash(const wchar_t *p) { size_t h = 5381, c; while ((c = *p++)) h = h * 33 + c ; return h ; }
int comp(const wchar_t *a, const wchar_t *b) { return *a-*b; }
int main(int args, char **argv)
{
	FILE *fp = fopen(argv[1], "r");
	char *line = NULL;
	size_t len = 0;
	ssize_t n;
	setlocale(LC_ALL, getenv("LANG"));
	GHashTable *hash = g_hash_table_new((guint (*)(gconstpointer))g_wcstr_hash,
										(gboolean (*) (gconstpointer, gconstpointer)) g_wcstr_equal);
	GArray *array;
	while ((n = getline(&line, &len, fp)) != -1) {
		line[n-1] = 0;
		wchar_t *wcs = malloc(n*sizeof(wchar_t));
		int wcslen = mbstowcs(wcs, line, n);
		for (int i=0; i < wcslen; i++) wcs[i] = towlower(wcs[i]);
		wchar_t *sorted = wcsdup(wcs);
		qsort(sorted, wcslen, sizeof(wchar_t), (int (*)(const void *, const void *))comp);
		if (!g_hash_table_lookup_extended(hash, sorted, NULL, (gpointer*)&array)) {
			array = g_array_new(FALSE, FALSE, sizeof(wchar_t*));
			g_array_append_val(array, wcs);
			g_hash_table_insert(hash, sorted, array);
		} else {
			g_array_append_val(array, wcs);
		}
	}
	g_hash_table_foreach(hash, (GHFunc)iterator, NULL);
	return 0;
}
